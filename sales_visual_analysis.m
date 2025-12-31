

% Visual Data Analysis of Business Sale Dataset 
% The data imported contains several lines and columns 
% Here we decode to visualize things which we need 

clc;
clear all;
close all;

% Loading the Dataset under variable 'a'

a = readtable("D:\Matlab\sales_data_sample.csv");

% Converting ORDERDATE to datetime

a.ORDERDATE = datetime(a.ORDERDATE,'InputFormat','dd/MM/yyyy HH:mm');

% Displaying the Whole Dataset in Command Window
% This whole display is not needed because we are here to analyse things

% disp(a);

% For reference loading head of the Dataset

disp(head(a));

%Plotting Sales vs Product Line (Bar Chart)

productLines = unique(a.PRODUCTLINE);
productSales = zeros(length(productLines),1);

for i = 1:length(productLines)
    idx = strcmp(a.PRODUCTLINE,productLines{i});
    productSales(i)= sum(a.SALES(idx));
end

figure;
bar(productSales);
set(gca,'XTickLabel',productLines);
xlabel("Product Line");
ylabel("Total Sales");
title("Total Sales by Product Line");
grid on;

% Monthly Sales Trend(Line Graph)

months = unique(a.MONTH_ID);
monthlySales = zeros(length(months),1);

for i = 1:length(months)
    idx = a.MONTH_ID == months(i);
    monthlySales(i) = sum(a.SALES(idx));
end

figure;
plot(months, monthlySales ,'-o');
xlabel('Month');
ylabel('Sales');
title('Monthly Sales Trend');
grid on;


% Top 5 Countries by Sales (Bar Chart)

countries = unique(a.COUNTRY);
countrySales = zeros(length(countries),1);

for i = 1:length(countries)
    idx = strcmp(a.COUNTRY,countries{i})
    countrySales(i) = sum(a.SALES(idx));
end

[countrySalesSorted , sortIdx] = sort(countrySales,'descend');
topCountries = countries(sortIdx(1:5));
topSales = countrySalesSorted(1:5);

figure;
bar(topSales);
set(gca,'XTickLabel',topCountries)
xlabel('Country');
ylabel('Sales');
title('Top 5 Countries by Sales');
grid on;


% Deal Size Contribution (Pie Chart)

dealSizes = unique(a.DEALSIZE);
dealSales = zeros(length(dealSizes),1);

for i =1:length(dealSizes)
    idx = strcmp(a.DEALSIZE,dealSizes{i});
    dealSales(i) = sum(a.SALES(idx));

end

figure;
pie(dealSales);
legend(dealSizes,'Location','bestoutside');
title('Sales Distribution by Deal Size');

% Sales Distribution (Histrogram)

figure;
histogram(a.SALES,20);
xlabel('Sales Amount');
ylabel('Frequency');
title('Distribution of Sales Values');
grid on;

% Quantity vs Sales (Scatter Plot)

figure;
scatter(a.QUANTITYORDERED,a.SALES,'filled');
xlabel('Quantity Ordered');
ylabel('Sales');
title('Quantity Ordered vs Sales');
grid on;
