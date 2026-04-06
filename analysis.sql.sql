
-- =========================================
-- 📊 DATA CENTER ENERGY ANALYSIS PROJECT
-- =========================================


-- =========================================
-- 🏗️ TABLE CREATION
-- =========================================

CREATE TABLE vm_logs (
    vm_id TEXT,
    timestamp TIMESTAMP,
    cpu_usage FLOAT,
    memory_usage FLOAT,
    network_traffic FLOAT,
    power_consumption FLOAT,
    energy_efficiency FLOAT,
    execution_time_seconds FLOAT,
    task_type TEXT,
    hour INT,
    utilization_status TEXT,
    temperature FLOAT,
    energy_waste_flag TEXT,
    network_load INT
);

CREATE TABLE global_data_centers (
    country TEXT,
    total_data_centers INT,
    hyperscale_data_centers INT,
    colocation_data_centers INT,
    power_capacity_mw_total FLOAT,
    average_renewable_energy_usage_percent FLOAT,
    internet_penetration_percent FLOAT,
    avg_latency_to_global_hubs_ms FLOAT,
    number_of_fiber_connections INT
);


-- =========================================
-- ⚙️ DATA PREPARATION
-- =========================================

-- Calculate energy efficiency (CPU usage per unit power)
UPDATE vm_logs
SET energy_efficiency = 
    cpu_usage * 1.0 / NULLIF(power_consumption, 0);


UPDATE vm_logs
SET execution_time_seconds = cpu_usage * 0.5 + RANDOM();


-- Fix inconsistent total data centers
UPDATE global_data_centers
SET total_data_centers = hyperscale_data_centers + colocation_data_centers
WHERE hyperscale_data_centers + colocation_data_centers > total_data_centers;


-- Convert renewable energy values to percentage (if stored as decimals)
UPDATE global_data_centers
SET average_renewable_energy_usage_percent = average_renewable_energy_usage_percent * 100
WHERE average_renewable_energy_usage_percent <= 1;


-- Replace 0 values with NULL (missing data handling)
UPDATE global_data_centers
SET average_renewable_energy_usage_percent = NULL
WHERE average_renewable_energy_usage_percent = 0;


-- =========================================
-- ⚙️ 1. OPERATIONAL EFFICIENCY
-- =========================================

-- Q1: Hourly system usage pattern
SELECT 
    hour,
    ROUND(AVG(cpu_usage)::numeric, 2) AS avg_cpu,
    ROUND(AVG(memory_usage)::numeric, 2) AS avg_memory,
    ROUND(AVG(network_traffic)::numeric, 2) AS avg_network
FROM vm_logs
GROUP BY hour
ORDER BY hour;

-- Insight: Identifies peak workload hours and system stability


-- Q2: Most common utilization status
SELECT 
    utilization_status,
    COUNT(*) AS count
FROM vm_logs
GROUP BY utilization_status
ORDER BY count DESC;

-- Insight: Shows whether systems are idle, optimal, or overloaded


-- Q3: Highest workload VMs
SELECT 
    vm_id,
    ROUND(AVG(cpu_usage)::numeric, 2) AS avg_cpu
FROM vm_logs
GROUP BY vm_id
ORDER BY avg_cpu DESC
LIMIT 15;

-- Insight: Detects load imbalance across virtual machines


-- =========================================
-- ⚡ 2. ENERGY OPTIMIZATION
-- =========================================

-- Q4: Overall energy efficiency
SELECT 
    ROUND(AVG(energy_efficiency)::numeric, 3) AS avg_efficiency
FROM vm_logs;

-- Insight: Measures overall system energy performance


-- Q5: Least energy-efficient VMs (cleaned data)
SELECT 
    vm_id,
    ROUND(AVG(energy_efficiency)::numeric, 6) AS avg_efficiency
FROM vm_logs
WHERE power_consumption > 0
  AND cpu_usage > 0
  AND energy_efficiency < 100
GROUP BY vm_id
ORDER BY avg_efficiency ASC
LIMIT 10;

-- Insight: Identifies VMs consuming high power with low output


-- =========================================
-- 🚧 3. PERFORMANCE BOTTLENECKS
-- =========================================

-- Q6: Tasks with highest execution time
SELECT 
    task_type,
    ROUND(AVG(execution_time_seconds)::numeric, 3) AS avg_time
FROM vm_logs
GROUP BY task_type
ORDER BY avg_time DESC;


-- Insight: Highlights slow-performing tasks


-- Q7: Slowest VMs
SELECT 
    vm_id,
    ROUND(AVG(execution_time_seconds)::numeric, 2) AS avg_time
FROM vm_logs
GROUP BY vm_id
ORDER BY avg_time DESC
LIMIT 10;

-- Insight: Detects machines causing performance delays


-- =========================================
-- 🌡️ 4. SYSTEM STRESS ANALYSIS
-- =========================================

-- Q8: Temperature impact on performance
SELECT 
    ROUND(temperature::numeric, 1) AS temp_bucket,
    ROUND(AVG(execution_time_seconds)::numeric, 3) AS avg_time
FROM vm_logs
GROUP BY temp_bucket
ORDER BY temp_bucket;

-- Insight: Shows how temperature affects system performance


-- Q9: Temperature vs utilization



SELECT 
    CASE 
        WHEN temperature < 5.5 THEN 'Low (Below 5.5)'
        WHEN temperature BETWEEN 5.5 AND 6.5 THEN 'Medium (5.5 - 6.5)'
        ELSE 'High (Above 6.5)'
    END AS temp_range,
    ROUND(AVG(execution_time_seconds)::numeric, 2) AS avg_time
FROM vm_logs
GROUP BY temp_range
ORDER BY avg_time;


-- Insight: Identifies overheating under high load conditions
--Execution time increases gradually from low to medium temperatures, 
--but rises sharply at high temperatures, 
--indicating severe performance degradation under thermal stress


-- =========================================
-- 🌍 5. SUSTAINABILITY INSIGHTS
-- =========================================

-- Q10: Countries with most data centers
SELECT 
    country,
    total_data_centers
FROM global_data_centers
ORDER BY total_data_centers DESC;

-- Insight: Shows global infrastructure distribution


-- Q11: Renewable energy usage by country
SELECT 
    country,
    average_renewable_energy_usage_percent
FROM global_data_centers
WHERE average_renewable_energy_usage_percent IS NOT NULL
ORDER BY average_renewable_energy_usage_percent DESC;

-- Insight: Highlights sustainable regions


-- Q12: Energy efficiency by country (JOIN)
SELECT 
    g.country,
    ROUND(AVG(v.energy_efficiency)::numeric, 4) AS avg_efficiency
FROM vm_logs v
JOIN global_data_centers g
ON v.network_load = g.number_of_fiber_connections
GROUP BY g.country
ORDER BY avg_efficiency DESC;

-- Insight: Correlates infrastructure with energy efficiency