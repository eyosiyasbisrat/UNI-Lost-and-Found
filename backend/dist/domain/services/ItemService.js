"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ItemService = void 0;
const ItemRepository_1 = require("../repositories/ItemRepository");
const mongoose_1 = __importDefault(require("mongoose"));
class ItemService {
    constructor() {
        this.itemRepository = new ItemRepository_1.ItemRepository();
    }
    async createItem(itemData) {
        return await this.itemRepository.create(itemData);
    }
    async getAllItems() {
        return await this.itemRepository.findAll();
    }
    async getItemById(id) {
        return await this.itemRepository.findById(id);
    }
    async getItemsByFoundBy(userId) {
        return await this.itemRepository.findByFoundBy(userId);
    }
    async getItemsByClaimedBy(userId) {
        return await this.itemRepository.findByClaimedBy(userId);
    }
    async updateItem(id, itemData) {
        const item = await this.itemRepository.findById(id);
        if (!item) {
            throw new Error("Item not found");
        }
        return await this.itemRepository.update(id, itemData);
    }
    async deleteItem(id) {
        const item = await this.itemRepository.findById(id);
        if (!item) {
            throw new Error("Item not found");
        }
        return await this.itemRepository.delete(id);
    }
    async getRecentItems(days = 7) {
        return await this.itemRepository.findRecentItems(days);
    }
    async getTodayItems() {
        return await this.itemRepository.findTodayItems();
    }
    async claimItem(itemId, userId) {
        const item = await this.itemRepository.findById(itemId);
        if (!item) {
            throw new Error("Item not found");
        }
        if (item.status !== "found") {
            throw new Error("Item is not available for claiming");
        }
        return await this.itemRepository.update(itemId, {
            status: "claimed",
            claimedBy: new mongoose_1.default.Types.ObjectId(userId),
        });
    }
    async markAsReturned(itemId) {
        const item = await this.itemRepository.findById(itemId);
        if (!item) {
            throw new Error("Item not found");
        }
        if (item.status !== "claimed") {
            throw new Error("Item must be claimed before marking as returned");
        }
        return await this.itemRepository.update(itemId, {
            status: "returned",
        });
    }
}
exports.ItemService = ItemService;
