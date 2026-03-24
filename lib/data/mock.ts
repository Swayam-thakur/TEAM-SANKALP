import { Worker } from "@/lib/types";

export const serviceCategories = [
  "Plumbing",
  "Electrical",
  "Carpentry",
  "AC Service",
  "Deep Cleaning",
  "Appliance Repair",
  "Painting",
  "Pest Control",
  "RO Service",
  "General Labor",
  "Packers & Movers",
  "Driver on Demand",
  "Tailoring",
  "Beauty at Home",
  "Elder Care",
  "Home Tutor",
  "Welding",
  "Mason Work"
];

export const workers: Worker[] = [
  {
    id: "wkr_raj_001",
    name: "Rajan Kumar",
    category: "Plumbing",
    rating: 4.8,
    completedJobs: 328,
    distanceKm: 1.2,
    etaMins: 12,
    verified: true,
    languages: ["Hindi", "English"],
    ratePerHour: 450,
    city: "Bengaluru"
  },
  {
    id: "wkr_pri_002",
    name: "Priya Sharma",
    category: "Electrical",
    rating: 4.7,
    completedJobs: 221,
    distanceKm: 2.1,
    etaMins: 19,
    verified: true,
    languages: ["Hindi", "Kannada"],
    ratePerHour: 500,
    city: "Bengaluru"
  },
  {
    id: "wkr_sal_003",
    name: "Salim Ansari",
    category: "Carpentry",
    rating: 4.6,
    completedJobs: 187,
    distanceKm: 0.8,
    etaMins: 10,
    verified: true,
    languages: ["Hindi", "Urdu"],
    ratePerHour: 420,
    city: "Pune"
  },
  {
    id: "wkr_mee_004",
    name: "Meena Devi",
    category: "Deep Cleaning",
    rating: 4.9,
    completedJobs: 412,
    distanceKm: 3.5,
    etaMins: 24,
    verified: true,
    languages: ["Hindi", "Marathi"],
    ratePerHour: 380,
    city: "Pune"
  }
];

export const cityStats = [
  { city: "Bengaluru", workers: 9500, jobs: 58200 },
  { city: "Pune", workers: 6400, jobs: 34100 },
  { city: "Hyderabad", workers: 7200, jobs: 39600 },
  { city: "Jaipur", workers: 3900, jobs: 20100 },
  { city: "Indore", workers: 3100, jobs: 15400 },
  { city: "Lucknow", workers: 3600, jobs: 17200 }
];
