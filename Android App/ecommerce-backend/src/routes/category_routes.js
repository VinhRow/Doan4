//thiết lập các đường dẫn để xử lý các yêu cầu của category_controller
const CategoryRoutes = require('express').Router();
const CategoryController = require('./../controllers/category_controller');

CategoryRoutes.get("/", CategoryController.fetchAllCategories);
CategoryRoutes.get("/:id", CategoryController.fetchCategoryById);
CategoryRoutes.post("/", CategoryController.createCategory);

module.exports = CategoryRoutes;