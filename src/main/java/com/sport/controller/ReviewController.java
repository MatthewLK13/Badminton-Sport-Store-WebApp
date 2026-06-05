package com.sport.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.sport.dao.ReviewDao;
import com.sport.dao.ProductDao;
import com.sport.entity.ReviewEntity;
import com.sport.entity.ProductsEntity;
import com.sport.entity.User;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sport.util.LocaleUtils;

@Controller
@RequestMapping("/review")
public class ReviewController {

    @Autowired
    private ReviewDao reviewDao;

    @Autowired
    private ProductDao productDao;

    @RequestMapping(value = "/add.htm", method = RequestMethod.POST)
    public String addReview(@RequestParam("productId") int productId,
                           @RequestParam("rating") int rating,
                           @RequestParam("comment") String comment,
                           HttpServletRequest request,
                           HttpSession session,
                           org.springframework.ui.Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login.htm";
        }

        if (rating < 1 || rating > 5) {
            model.addAttribute("error", LocaleUtils.msg(request, "review.rating.invalid"));
            return "redirect:/products/details.htm?id=" + productId;
        }

        // Check if user already reviewed this product
        if (reviewDao.hasUserReviewed(user.getId(), productId)) {
            model.addAttribute("error", LocaleUtils.msg(request, "review.exists"));
            return "redirect:/products/details.htm?id=" + productId;
        }

        ProductsEntity product = productDao.getProductById(productId);
        if (product == null) {
            return "redirect:/home.htm";
        }

        ReviewEntity review = new ReviewEntity(user, product, rating, comment);
        reviewDao.save(review);

        return "redirect:/products/details.htm?id=" + productId;
    }

    @RequestMapping(value = "/product/{productId}.htm", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> getProductReviews(@PathVariable int productId) {
        List<ReviewEntity> reviews = reviewDao.getByProductId(productId);
        Double avgRating = reviewDao.getAverageRating(productId);
        int count = reviewDao.countByProductId(productId);

        Map<String, Object> result = new HashMap<>();
        result.put("reviews", reviews);
        result.put("averageRating", avgRating);
        result.put("count", count);
        return result;
    }
}
