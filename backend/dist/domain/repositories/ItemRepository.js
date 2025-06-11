"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ItemRepository = void 0;
const Item_1 = require("../models/Item");
class ItemRepository {
    async create(itemData) {
        console.log(itemData);
        const item = new Item_1.Item(itemData);
        return await item.save();
    }
    async findAll() {
        return await Item_1.Item.find()
            .populate("foundBy", "fullName email")
            .populate("claimedBy", "fullName email")
            .sort({ dateFound: -1 });
    }
    async findById(id) {
        return await Item_1.Item.findById(id)
            .populate("foundBy", "fullName email")
            .populate("claimedBy", "fullName email");
    }
    async findByFoundBy(userId) {
        return await Item_1.Item.find({ foundBy: userId })
            .populate("foundBy", "fullName email")
            .populate("claimedBy", "fullName email")
            .sort({ dateFound: -1 });
    }
    async findByClaimedBy(userId) {
        return await Item_1.Item.find({ claimedBy: userId })
            .populate("foundBy", "fullName email")
            .populate("claimedBy", "fullName email")
            .sort({ dateFound: -1 });
    }
    async update(id, itemData) {
        return await Item_1.Item.findByIdAndUpdate(id, itemData, { new: true })
            .populate("foundBy", "fullName email")
            .populate("claimedBy", "fullName email");
    }
    async delete(id) {
        return await Item_1.Item.findByIdAndDelete(id);
    }
    async findRecentItems(days = 7) {
        const date = new Date();
        date.setDate(date.getDate() - days);
        return await Item_1.Item.find({
            dateFound: { $gte: date },
        })
            .populate("foundBy", "fullName email")
            .populate("claimedBy", "fullName email")
            .sort({ dateFound: -1 });
    }
    async findTodayItems() {
        const today = new Date();
        today.setHours(0, 0, 0, 0);
        return await Item_1.Item.find({
            dateFound: { $gte: today },
        })
            .populate("foundBy", "fullName email")
            .populate("claimedBy", "fullName email")
            .sort({ dateFound: -1 });
    }
}
exports.ItemRepository = ItemRepository;
