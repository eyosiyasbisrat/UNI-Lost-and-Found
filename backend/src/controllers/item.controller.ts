import { Request, Response } from 'express';
import { ItemService } from '../application/services/item.service';

export class ItemController {
  private itemService: ItemService;

  constructor() {
    this.itemService = new ItemService();
  }

  getAllItems = async (req: Request, res: Response) => {
    try {
      const items = await this.itemService.getAllItems();
      res.json(items);
    } catch (error) {
      res.status(500).json({ message: 'Error fetching items', error });
    }
  };

  addFoundItem = async (req: Request, res: Response) => {
    try {
      const item = await this.itemService.addItem({
        ...req.body,
        status: 'found',
      });
      res.status(201).json(item);
    } catch (error) {
      res.status(500).json({ message: 'Error adding found item', error });
    }
  };

  addLostItem = async (req: Request, res: Response) => {
    try {
      const item = await this.itemService.addItem({
        ...req.body,
        status: 'lost',
      });
      res.status(201).json(item);
    } catch (error) {
      res.status(500).json({ message: 'Error adding lost item', error });
    }
  };

  deleteItem = async (req: Request, res: Response) => {
    try {
      await this.itemService.deleteItem(req.params.id);
      res.status(200).json({ message: 'Item deleted successfully' });
    } catch (error) {
      res.status(500).json({ message: 'Error deleting item', error });
    }
  };
} 