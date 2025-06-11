import { Item } from '../models/item.model';
import { ItemModel } from '../../infrastructure/models/item.model';

export class ItemRepository {
  async findAll(): Promise<Item[]> {
    return ItemModel.find();
  }

  async create(itemData: Partial<Item>): Promise<Item> {
    const item = new ItemModel(itemData);
    return item.save();
  }

  async delete(id: string): Promise<void> {
    await ItemModel.findByIdAndDelete(id);
  }
} 