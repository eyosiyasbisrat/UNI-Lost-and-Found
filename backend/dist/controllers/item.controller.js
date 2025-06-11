"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ItemController = void 0;
const item_service_1 = require("../application/services/item.service");
class ItemController {
    constructor() {
        this.getAllItems = async (req, res) => {
            try {
                const items = await this.itemService.getAllItems();
                res.json(items);
            }
            catch (error) {
                res.status(500).json({ message: 'Error fetching items', error });
            }
        };
        this.addFoundItem = async (req, res) => {
            try {
                const item = await this.itemService.addItem({
                    ...req.body,
                    status: 'found',
                });
                res.status(201).json(item);
            }
            catch (error) {
                res.status(500).json({ message: 'Error adding found item', error });
            }
        };
        this.addLostItem = async (req, res) => {
            try {
                const item = await this.itemService.addItem({
                    ...req.body,
                    status: 'lost',
                });
                res.status(201).json(item);
            }
            catch (error) {
                res.status(500).json({ message: 'Error adding lost item', error });
            }
        };
        this.deleteItem = async (req, res) => {
            try {
                await this.itemService.deleteItem(req.params.id);
                res.status(200).json({ message: 'Item deleted successfully' });
            }
            catch (error) {
                res.status(500).json({ message: 'Error deleting item', error });
            }
        };
        this.itemService = new item_service_1.ItemService();
    }
}
exports.ItemController = ItemController;
