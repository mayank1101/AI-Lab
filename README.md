# AI & Analytics Portfolio

This repository is a centralized portfolio of applied AI, machine learning, data analytics, and SQL work. It combines notebook-based case studies, Udacity deep learning projects, computer vision pipelines, NLP models, deployment exercises, and SQL analytics assignments.

## Repository Overview

| Area | Folder | Focus |
| --- | --- | --- |
| Udacity projects | [UdacityProjects](UdacityProjects) | Deep learning, computer vision, NLP, model deployment, medical imaging, and SLAM |
| DataCamp projects | [DataCampProjects](DataCampProjects) | Exploratory data analysis, visualization, pandas workflows, and applied analytics case studies |
| SQL practice | [NamasteSQL](NamasteSQL) | SQL fundamentals, analytical SQL, joins, CTEs, window functions, stored procedures, indexes, and portfolio queries |

## Udacity Projects

| Project | What it does | Main techniques and artifacts |
| --- | --- | --- |
| [Automatic Image Captioning](UdacityProjects/Project%20-%20Automatic%20Image%20Captioning) | Builds a CNN-RNN pipeline that learns to generate captions for images from the MS COCO dataset. | PyTorch, torchvision, COCO API, vocabulary building, `EncoderCNN`, `DecoderRNN`, training and inference notebooks, saved encoder/decoder checkpoints |
| [Bike Sharing Prediction](UdacityProjects/Project%20-%20Bike%20sharing%20prediction) | Predicts bike rental ridership from historical bike sharing data. | NumPy neural network implementation, pandas preprocessing, categorical encoding, feature scaling, train/validation/test workflow |
| [Dog Breed Classifier](UdacityProjects/Project%20-%20Dog%20Breed%20Classifier) | Implements a dog identification app workflow that detects humans/dogs and predicts dog breeds. | CNN concepts, OpenCV Haar cascades, image preprocessing, transfer learning workflow in notebook form |
| [Facial Key Point Detection](UdacityProjects/Project%20-%20Facial%20Key%20Point%20Detection) | Trains a convolutional neural network to locate facial keypoints and applies them in an end-to-end face pipeline. | PyTorch, custom `Dataset`, image transforms, CNN model in `models.py`, Haar cascade detectors, saved model checkpoint, optional face filter notebook |
| [Image Style Transfer](UdacityProjects/Project%20-%20Image%20Style%20Transfer) | Recreates neural style transfer using deep image features. | PyTorch, VGG19 feature extraction, content/style loss, optimization-based image generation, Gatys paper reference |
| [Object Tracking and Localization](UdacityProjects/Project%20-%20Object%20Tracking%20and%20Localization) | Implements robot sensing, motion, landmark detection, and Graph SLAM in a 2D world. | SLAM, omega/xi constraints, robot simulation, motion and measurement noise, helper visualization code |
| [Pneumonia Detection from Chest X-Rays](UdacityProjects/Project%20-%20Pneumonia%20Detection%20from%20Chest%20X-Rays) | Explores chest X-ray metadata, trains a pneumonia classification model, and prepares inference/FDA-style documentation. | Keras, image augmentation, DICOM handling, pydicom, EDA notebook, training notebook, inference notebook, sample DICOM files, FDA submission materials |
| [Sentimental Analysis](UdacityProjects/Project%20-%20Sentimental%20Analysis) | Frames sentiment classification as a neural network problem using review text and labels. | NLP preprocessing, word counts, sentiment ratios, NumPy-based learning workflow |
| [Deploying Sentiment Analysis Model](UdacityProjects/Project-%20Deploying%20Sentiment%20Analysis%20Model) | Builds and deploys a sentiment analysis web app backed by a PyTorch LSTM model on SageMaker. | PyTorch LSTM, SageMaker training and serving scripts, inference handlers, text cleaning utilities, HTML front end, deployment diagram |
| [TV Script Generation](UdacityProjects/Project-%20TV%20Script%20Generation) | Generates Seinfeld-style TV scripts from dialogue data. | Recurrent neural networks, sequence modeling, token lookup tables, PyTorch checkpoint, generated script output |

## DataCamp Projects

| Project | What it analyzes | Data and skills demonstrated |
| --- | --- | --- |
| [A Visual History of Nobel Prize Winners](DataCampProjects/A%20Visual%20History%20of%20Nobel%20Prize%20Winners) | Nobel Prize winners across year, category, country, gender, organization, and laureate attributes. | Historical EDA, grouped summaries, trend analysis, visualization-ready Nobel dataset |
| [Analyzing Netflix Data](DataCampProjects/Analyzing%20Netflix%20Data) | Netflix titles by type, release year, country, duration, genre, and metadata. | pandas filtering, content catalog analysis, movie/TV comparison, exploratory visualization |
| [Analyzing TV Data](DataCampProjects/Analyzing%20TV%20Data) | Super Bowl TV viewership, advertising cost, game outcomes, and halftime musicians. | Joins across multiple CSVs, sports/media analytics, viewer and ad-cost trends |
| [Do Left-handed People Really Die Young?](DataCampProjects/Do%20Left-handed%20People%20Really%20Die%20Young_) | Project folder for the left-handedness case study; the checked-in dataset is the Iris dataset. | Notebook-based EDA structure, small tabular dataset exploration |
| [Exploring the Evolution of Linux](DataCampProjects/Exploring%20the%20Evolution%20of%20Linux) | Linux git history using commit timestamps and authors. | Compressed data loading, contribution history analysis, author/activity trends |
| [Name Game: Gender Prediction using Sound](DataCampProjects/Name%20Game_%20Gender%20Prediction%20using%20Sound) | Predicts likely gender patterns in names using SSA baby names, NYSIIS encodings, and children's book author names. | Phonetic encoding, name normalization, grouped probability features |
| [TV, Halftime Shows, and the Big Game](DataCampProjects/TV,%20Halftime%20Shows,%20and%20the%20Big%20Game) | Super Bowl game, TV, and halftime performance data. | Multi-table EDA, sports analytics, event and media trend analysis |
| [The Android App Market on Google Play](DataCampProjects/The%20Android%20App%20Market%20on%20Google%20Play) | Google Play app metadata and user review sentiment. | Data cleaning, category analysis, ratings/reviews exploration, sentiment polarity and subjectivity analysis |
| [The GitHub History of the Scala Language](DataCampProjects/The%20GitHub%20History%20of%20the%20Scala%20Language) | Scala pull requests, changed files, contributors, and timeline history. | GitHub activity analysis, time series aggregation, contributor/file-level exploration |
| [Who Is Drunk and When in Ames, Iowa?](DataCampProjects/Who%20Is%20Drunk%20and%20When%20in%20Ames,%20Iowa_) | Breath alcohol test results by date, hour, location, gender, and measurement values. | Time-based EDA, public safety analytics, grouping by hour/location/month |

## NamasteSQL

The [NamasteSQL](NamasteSQL) folder contains structured SQL learning material and solved assignments. The work progresses from SQL basics to advanced analytical querying.

| Module | Folder | Topics covered |
| --- | --- | --- |
| 1 | [Introduction to SQL, DDL, DML, and DQL](NamasteSQL/1.introduction_to_sql_ddl_dml_and_dql) | Table creation, constraints, primary keys, foreign keys, data types, inserts, updates, and basic querying |
| 2 | [Filters, Sorting, and CASE WHEN](NamasteSQL/2.sql_filters_sorting_and_case_when) | `WHERE`, `LIKE`, date filters, `IN`, `NOT IN`, ordering, default constraints, and conditional logic |
| 3 | [Aggregation and Joins](NamasteSQL/3.aggregation_and_joins) | `GROUP BY`, aggregate functions, profit buckets, joins, customer/order analysis |
| 4 | [Self Join, Date/String Functions, Set Operations, and Views](NamasteSQL/4.selfjoin_date_and_string_functions_set_operations_and_view) | Self joins, manager hierarchies, date calculations, string parsing, set logic, views |
| 5 | [Subquery, CTE, and Temporary Tables](NamasteSQL/5.subquery_cet_and_temporary_tables) | CTEs, subqueries, premium customer logic, department averages, highest-selling products |
| 6 | [Window Functions and Recursive CTE](NamasteSQL/6.window_analytical_functions_and_recursive_cte) | Ranking, `DENSE_RANK`, `ROW_NUMBER`, top/bottom analysis, month-over-month and year-over-year growth |
| 7 | [Advanced Aggregation, Stored Procedures, and Functions](NamasteSQL/7.advance_aggregation_stored_procedures_and_functions) | Rolling three-month sales, products with non-declining sales, business-day functions, stored procedure exercises |
| 8 | [Portfolio Project: Credit Card Transactions](NamasteSQL/8.portfolio_project_credit_cars_transactions) | Credit card spend analysis by city, card type, month, expense type, gender contribution, and cumulative spend |
| 9 | [Database Indexes, Advanced Update, and Merge](NamasteSQL/9.database_indexes_advance_update_and_merge) | Clustered indexes, nonclustered indexes, advanced update patterns, merge concepts |

Additional consolidated SQL material is stored in:

- [NamasteSQL/all_assignments](NamasteSQL/all_assignments): assignment prompts and reference solutions by day.
- [NamasteSQL/all_projects](NamasteSQL/all_projects): credit card transactions portfolio questions and solution SQL.

## Skills Demonstrated

- Python data analysis with pandas, NumPy, matplotlib, seaborn, and notebook workflows.
- Deep learning with PyTorch, Keras, CNNs, RNNs, LSTMs, transfer learning, and image feature extraction.
- Computer vision tasks including image captioning, facial keypoint detection, style transfer, dog breed classification, and medical image classification.
- NLP tasks including sentiment classification, script generation, tokenization, vocabulary construction, and text cleaning.
- Model deployment patterns using SageMaker training/serving scripts and a simple web app front end.
- SQL analytics across joins, CTEs, window functions, stored procedures, functions, indexes, and portfolio-style business questions.

## Notes

- Most projects are notebook-first and include local datasets or supporting artifacts.
- Some Udacity projects include large generated files, trained checkpoints, HTML exports, PDF exports, or submission archives.
- The repository is intended as a learning and portfolio archive rather than a single installable Python package.
