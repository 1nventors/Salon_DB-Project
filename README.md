# Salon Appointment Scheduler 💇‍♀️💇‍♂️  

This project is part of the **Relational Database Certification** from [freeCodeCamp](https://www.freecodecamp.org/).  
The goal was to create an **interactive Bash program** that uses **PostgreSQL** to manage customers and appointments for a salon.  

---

## 📌 Features  

- Interactive Bash menu.  
- View and select available salon services.  
- Customer management:  
  - New customers are automatically registered.  
  - Returning customers are recognized by phone number.  
- Schedule appointments with selected services and time.  
- Stores all data in a PostgreSQL relational database.  

---

## 🛠️ Technologies Used  

- **Bash scripting** (interactive program logic).  
- **PostgreSQL** (database management and persistence).
- **Gitpod** (for running the PostgreSQL in a virtual machine).  

---

## 🗄️ Database Structure  

The PostgreSQL database is named **`salon`** and contains three tables:  

### `customers` table  
| Column       | Type         | Description |
|--------------|-------------|-------------|
| `customer_id`| SERIAL (PK) | Unique identifier of the customer |
| `phone`      | VARCHAR     | Customer phone number (unique) |
| `name`       | VARCHAR     | Customer name |

### `services` table  
| Column      | Type         | Description |
|-------------|-------------|-------------|
| `service_id`| SERIAL (PK) | Unique identifier of the service |
| `name`      | VARCHAR     | Service name (cut, color, perm, etc.) |

### `appointments` table  
| Column         | Type         | Description |
|----------------|-------------|-------------|
| `appointment_id`| SERIAL (PK) | Unique identifier of the appointment |
| `time`         | VARCHAR     | Appointment time |
| `customer_id`  | INT (FK)    | References `customers(customer_id)` |
| `service_id`   | INT (FK)    | References `services(service_id)` |

---

## 🎮 Example Interaction  

Welcome to My Salon, how can I help you?
1) cut
2) color
3) perm
4) style
5) trim


📱 **New customer flow**:  

Please put your phone number here:
```
555-1234
```
You are a new customer! Please insert your name:
```
Alice
```
What time would you like to cut, Alice?
```
2pm
```
I have put you down for a cut at 2pm, Alice.

📞 **Returning customer flow**:  

Please put your phone number here:
```
555-9999
```
What time would you like to color, Bob?
```
3:30pm
```
I have put you down for a color at 3:30pm, Bob.

