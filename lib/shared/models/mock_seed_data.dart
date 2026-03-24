import 'service_category.dart';

const mockServiceCategories = [
  ServiceCategory(
    id: 'cleaning',
    name: 'Home Cleaning',
    description: 'Deep cleaning, kitchen cleaning, and routine upkeep.',
    iconKey: 'cleaning_services',
    basePrice: 499,
    isActive: true,
  ),
  ServiceCategory(
    id: 'plumbing',
    name: 'Plumbing',
    description: 'Leak fixes, bathroom fittings, and emergency plumbing.',
    iconKey: 'plumbing',
    basePrice: 299,
    isActive: true,
  ),
  ServiceCategory(
    id: 'electrical',
    name: 'Electrical',
    description: 'Switchboards, lights, fan repair, and wiring checks.',
    iconKey: 'electrical_services',
    basePrice: 349,
    isActive: true,
  ),
  ServiceCategory(
    id: 'beauty',
    name: 'Beauty at Home',
    description: 'Salon and grooming appointments at your doorstep.',
    iconKey: 'beauty',
    basePrice: 699,
    isActive: true,
  ),
  ServiceCategory(
    id: 'appliance',
    name: 'Appliance Repair',
    description: 'AC, fridge, washing machine, and microwave repair.',
    iconKey: 'appliance_repair',
    basePrice: 399,
    isActive: true,
  ),
];

