const CategoryModel = require('./../models/category_model');
//Category Controller để xử lý các yêu cầu thê loại sản phẩm
const CategoryController = {
    //Taoh thể loại sản phẩm
    createCategory: async function (req, res) {
        try {
            const categoryData = req.body;
            const newCategory = new CategoryModel(categoryData);
            await newCategory.save();

            return res.json({ success: true, data: newCategory, message: "Đã thêm loại sản phẩm!" });
        }
        catch (ex) {
            return res.json({ success: false, message: ex });
        }
    },
    //Lấy tất cả thê loại sản phẩm
    fetchAllCategories: async function (req, res) {
        try {
            const categories = await CategoryModel.find();
            return res.json({ success: true, data: categories });
        }
        catch (ex) {
            return res.json({ success: false, message: ex });
        }
    },
    //Lấy thế loại sản phẩm bằng id
    fetchCategoryById: async function (req, res) {
        try {
            const id = req.params.id;
            const foundCategory = await CategoryModel.findById(id);

            if (!foundCategory) {
                return res.json({ success: false, message: "Không tìm thấy loại sản phẩm!" });
            }

            return res.json({ success: true, data: foundCategory });
        }
        catch (ex) {
            return res.json({ success: false, message: ex });
        }
    }

};

module.exports = CategoryController;