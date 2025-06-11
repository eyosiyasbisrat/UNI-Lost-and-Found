import { Item } from '../../domain/models/item.model';
import { ItemRepository } from '../../domain/repositories/item.repository';

export class ItemService {
  private itemRepository: ItemRepository;

  constructor() {
    this.itemRepository = new ItemRepository();
  }

  async getAllItems(): Promise<Item[]> {
    return this.itemRepository.findAll();
  }

  async addItem(itemData: Partial<Item>): Promise<Item> {
    return this.itemRepository.create(itemData);
  }

  async deleteItem(id: string): Promise<void> {
    await this.itemRepository.delete(id);
  }
} 