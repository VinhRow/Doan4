//thiết lập các đường dẫn để xử lý các yêu cầu của cart_controller
const CartRoutes = require('express').Router();
const CartController = require('./../controllers/cart_controller');

CartRoutes.get("/:user", CartController.getCartForUser);
CartRoutes.post("/", CartController.addToCart);
CartRoutes.delete("/", CartController.removeFromCart);

module.exports = CartRoutes;