"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ItemRepository = void 0;
const item_model_1 = require("../../infrastructure/models/item.model");
class ItemRepository {
    async findAll() {
        return item_model_1.ItemModel.find();
    }
    async create(itemData) {
        const item = new item_model_1.ItemModel(itemData);
        return item.save();
    }
    async delete(id) {
        await item_model_1.ItemModel.findByIdAndDelete(id);
    }
}
exports.ItemRepository = ItemRepository;
