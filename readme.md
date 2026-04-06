# **⚡ Data Center Energy Efficiency & Performance Analysis**

**Author:** [Tanmay Sharma](https://www.linkedin.com/in/tanmay-sharma-data/) | 🔗 [LinkedIn Profile](https://www.linkedin.com/in/tanmay-sharma-data)

## **📊 Project Overview**

This project analyzes data center operations with a primary focus on performance metrics, energy efficiency, and global sustainability trends. By leveraging **SQL** for data transformation and **Power BI** for visualization, the project provides actionable insights into resource utilization, power consumption patterns, and the global distribution of data infrastructure.

## **🎯 Objectives**

* **Performance Monitoring:** Analyze CPU, memory, and network usage across various tasks.  
* **Energy Optimization:** Identify patterns in energy consumption and detect potential waste.  
* **Efficiency Evaluation:** Compare execution times and resource allocation across different task types.  
* **Sustainability Mapping:** Study global data center distribution and the adoption of renewable energy.

## **🛠 Tools & Technologies**

* **Database:** SQL (PostgreSQL) for data cleaning and aggregation.  
* **Visualization:** Power BI for interactive dashboarding.  
* **Data Processing:** Excel / CSV for initial data handling.

## **📂 Dataset Description**

The analysis is driven by two primary datasets:

### **1\. VM Logs Data**

Contains granular metrics regarding virtual machine performance:

* **CPU Usage (%)**  
* **Memory Usage**  
* **Network Traffic**  
* **Power Consumption**  
* **Execution Time**  
* **Task Type** (e.g., Compute, Storage, Analytics)

### **2\. Global Data Center Data**

Focuses on the macro-scale infrastructure:

* **Country & Region**  
* **Total Data Centers Count**  
* **Power Capacity**  
* **Renewable Energy Usage**  
* **Internet Penetration Rates**

## **📊 Dashboard Features**

### **🔹 Performance Analysis**

* **Trend Lines:** CPU usage fluctuations over time.  
* **Task Comparison:** Execution time and resource demand categorized by task type.  
* **Correlation Plots:** CPU vs. Memory usage analysis to identify bottlenecks.  
* **Network Load:** Hourly analysis of incoming and outgoing traffic.

### **🔹 Energy Optimization**

* **Consumption Trends:** Monthly energy usage tracking.  
* **Efficiency Metrics:** Power vs. Performance analysis using the formula:![][image1]  
* **Waste Distribution:** Identifying idle resource periods and energy overhead.

### **🔹 Sustainability Insights**

* **Geospatial Mapping:** Top countries by data center density.  
* **Green Energy:** Comparative analysis of renewable energy adoption by region.  
* **Capacity Analysis:** Power capacity vs. total data center count.

## **🔍 Key Insights**

1. **Over-Provisioning:** Resource usage remains relatively static even during low-demand tasks, suggesting potential for dynamic resource allocation.  
2. **Optimization Gaps:** Energy consumption patterns show significant peaks that do not always correlate with high performance, indicating cooling or idle waste.  
3. **Regional Concentration:** Data center infrastructure is heavily concentrated in specific geographical hubs, impacting latency and global energy load.  
4. **Sustainability Progress:** While renewable energy usage is rising, there is a clear gap between power capacity growth and green energy adoption in emerging markets.

## **📁 Project Structure**

├── data/               \# Raw and processed CSV/Excel files  
├── images/             \# Dashboard screenshots and icons  
├── sql/                \# SQL scripts for cleaning and analysis  
├── dashboard.pbix      \# Power BI Dashboard file  
└── README.md           \# Project documentation

## **🗄 SQL Analysis**

The SQL component of this project involves:

* **Data Cleaning:** Handling null values and standardizing units (e.g., converting MS to Seconds).  
* **Aggregations:** Calculating average utilization and total power draw per task category.  
* **Time-Series Transformation:** Bucketing logs into hourly and daily intervals for trend analysis.

## **🚀 Conclusion**

This project demonstrates how data-driven analysis can significantly improve operational efficiency and reduce the environmental footprint of modern data centers. By visualizing the intersection of performance and power, organizations can make better-informed decisions regarding sustainable infrastructure.

## **📌 Future Improvements**

* **Real-time Integration:** Connecting the dashboard to live API streams for real-time monitoring.  
* **Predictive Modeling:** Implementing Machine Learning (ML) to predict server failure and peak load times.  
* **Cost Analysis:** Integrating financial data to model cost-per-task optimization.

[image1]: <data:image/png;base64,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>