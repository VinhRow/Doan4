//thiết lập các đường dẫn để xử lý các yêu cầu của product_controller
const ProductRoutes = require('express').Router();
const ProductController = require('./../controllers/product_controller');

ProductRoutes.get("/", ProductController.fetchAllProducts);
ProductRoutes.get("/category/:id", ProductController.fetchProductByCategory);
ProductRoutes.post("/", ProductController.createProduct);

module.exports = ProductRoutes;