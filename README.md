# Data Engineering Case Study: Full-Stack Database Architecture & Intelligence for "Nexus Hardware Group" 💻📊

## 📖 Executive Summary
**Nexus Hardware Group** is a high-performance computing retailer that required a scalable and reliable system to manage its global inventory. In this project, I architected and implemented the entire database infrastructure from the ground up using a professional-grade relational environment. 

The project involved designing the relational schema, performing complex ETL (Extract, Transform, Load) processes, and developing an analytical layer to solve operational inefficiencies and provide strategic market insights for the sales and procurement departments.

---

## 🛠️ Strategic Business Solutions
Below are the 9 strategic business questions I solved using advanced SQL:

* **Logistics Correction**: Standardized the storage records by updating incorrect destination codes ('100') to 'Invalid_destination'.
* **Database Maintenance**: Purged invalid entries from storage logs to optimize database performance and maintain data hygiene.
* **Brand Inventory Audit**: Generated a comprehensive report of all products manufactured by Dell for inventory tracking.
* **Market Pricing Analysis**: Produced a sorted list of all devices from most to least expensive to evaluate market positioning.
* **Supplier Volume Audit**: Calculated the total inventory volume for Hitachi laptops to assist in supply chain planning.
* **Premium Product Ranking**: Identified the flagship (most expensive) product model for every manufacturer in the database using Window Functions.
* **Specialization Mapping**: Isolated manufacturers specialized in peripherals by identifying those who produce more printers than computers.
* **Niche Market Search**: Located the highest-priced PC without a CD drive for manufacturers who exclusively produce PCs.
* **Automated Recommendation Engine**: Developed a search logic that accepts performance specs (Speed, RAM, HD) to find the cheapest computer matching customer needs.

---

## 📂 Database Structure
The architecture follows a strictly relational model to ensure data integrity.

[Image of a relational database schema diagram showing tables for Product, PC, Laptop, Printer, and Storage connected by foreign keys]

* [cite_start]**Product Table**: The master table for brands and categories [cite: 81-84].
* [cite_start]**Hardware Tables (PC, Laptop, Printer)**: Specialized tables containing technical specifications linked by foreign keys [cite: 85-115].
* [cite_start]**Storage Table**: A logistics log tracking product movement and serial numbers [cite: 116-121].

---

## 🧰 Technical Stack
* **Environment**: Professional Relational Database Management System.
* **Languages**: SQL (Advanced DDL, DML, DQL).
* **Advanced Techniques**: Window Functions (`ROW_NUMBER`), `UNION ALL`, `CASE` logic, Subqueries, and Referential Integrity.

---

## 🚀 How to Run
1.  [cite_start]**Execute Schema**: Run the script in `/scripts/01_ddl_creation.sql` to build the tables and constraints [cite: 81-121].
2.  [cite_start]**Load Data**: Run `/scripts/02_dml_population.sql` to populate the environment with validated hardware records [cite: 122-199].
3.  **Run Analytics**: Use `/scripts/03_business_queries.sql` to execute the business intelligence reports.
