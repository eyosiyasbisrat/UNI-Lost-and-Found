"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ItemService = void 0;
const item_repository_1 = require("../../domain/repositories/item.repository");
class ItemService {
    constructor() {
        this.itemRepository = new item_repository_1.ItemRepository();
    }
    async getAllItems() {
        return this.itemRepository.findAll();
    }
    async addItem(itemData) {
        return this.itemRepository.create(itemData);
    }
    async deleteItem(id) {
        await this.itemRepository.delete(id);
    }
}
exports.ItemService = ItemService;
