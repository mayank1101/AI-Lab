# AI & Analytics Lab

A portfolio and learning archive covering artificial intelligence, machine learning, deep learning, computer vision, natural language processing, data analytics, MLOps, SQL, and web search engine crawlers.

The repository combines completed projects with the coursework, assignments, certificates, datasets, and reference material that supported them. It is organized as an archive of independent projects and notebooks rather than a single installable application.

## Repository Map

| Directory | Description |
| --- | --- |
| [the-aiml-playbook/](the-aiml-playbook/) | Applied portfolio work: 10 deep learning, computer vision, and NLP projects from Udacity. |
| [the-analytics-mosaic/](the-analytics-mosaic/) | Applied portfolio work: 10 exploratory data analysis and visualization case studies from DataCamp. |
| [stackoverflow-search-engine-project/](stackoverflow-search-engine-project/) | A full-stack search engine application built with Django and Scrapy crawlers for StackExchange sites. |
| [Courses/](Courses/) | Course notebooks, assignments, certificates, and reference material from Coursera, DeepLearning.AI, Udacity, and DataCamp. Also includes the 9-module `NamasteSQL` learning track. See the [course catalog](Courses/README.md). |

```text
Mayank-AI-Lab/
├── Courses/
│   ├── Coursera/
│   ├── DeepLearning.AI/
│   ├── NamasteSQL/
│   ├── datacamp/
│   ├── datascience_Cheat_Sheets/
│   ├── others/
│   └── udacity/
├── stackoverflow-search-engine-project/
│   ├── crawlers/
│   ├── data/
│   └── engine/
├── the-aiml-playbook/
│   ├── Project - Automatic Image Captioning/
│   └── [9 other deep learning & NLP projects]
├── the-analytics-mosaic/
│   ├── A Visual History of Nobel Prize Winners/
│   └── [9 other data analytics projects]
├── LICENSE
└── README.md
```

## Featured Work

| Project | Area | Highlights |
| --- | --- | --- |
| [Automatic Image Captioning](the-aiml-playbook/Project%20-%20Automatic%20Image%20Captioning/) | Computer vision and NLP | CNN encoder, RNN decoder, MS COCO data, training and inference notebooks, saved checkpoints |
| [Pneumonia Detection from Chest X-Rays](the-aiml-playbook/Project%20-%20Pneumonia%20Detection%20from%20Chest%20X-Rays/) | Medical imaging | DICOM exploration, Keras classification, threshold evaluation, inference pipeline, FDA-style report |
| [Facial Keypoint Detection](the-aiml-playbook/Project%20-%20Facial%20Key%20Point%20Detection/) | Computer vision | PyTorch CNN regression, image augmentation, Haar cascades, end-to-end face processing |
| [Deploying a Sentiment Analysis Model](the-aiml-playbook/Project-%20Deploying%20Sentiment%20Analysis%20Model/) | NLP and deployment | PyTorch LSTM, SageMaker training and serving code, inference handlers, web client |
| [Object Tracking and Localization](the-aiml-playbook/Project%20-%20Object%20Tracking%20and%20Localization/) | Robotics | Robot motion and sensing, landmark constraints, Graph SLAM |
| [Credit Card Transactions Analysis](Courses/NamasteSQL/all_projects/) | SQL analytics | Business-oriented queries using aggregation, ranking, window functions, and cumulative metrics |

---

## Applied Project Catalogs

### The AI/ML Playbook (Udacity Projects)

Located under [the-aiml-playbook/](the-aiml-playbook/), this portfolio contains deep learning, computer vision, and NLP implementations.

| Project | Description | Main Techniques & Artifacts |
| --- | --- | --- |
| [Automatic Image Captioning](the-aiml-playbook/Project%20-%20Automatic%20Image%20Captioning/) | Builds a CNN-RNN pipeline that learns to generate captions for images from the MS COCO dataset. | PyTorch, torchvision, COCO API, vocabulary building, `EncoderCNN`, `DecoderRNN`, training/inference notebooks, saved checkpoints |
| [Bike Sharing Prediction](the-aiml-playbook/Project%20-%20Bike%20sharing%20prediction/) | Predicts bike rental ridership from historical bike sharing data. | NumPy neural network implementation, pandas preprocessing, categorical encoding, feature scaling, train/validation/test workflow |
| [Dog Breed Classifier](the-aiml-playbook/Project%20-%20Dog%20Breed%20Classifier/) | Implements a dog identification app workflow that detects humans/dogs and predicts dog breeds. | CNN concepts, OpenCV Haar cascades, image preprocessing, transfer learning workflow |
| [Facial Keypoint Detection](the-aiml-playbook/Project%20-%20Facial%20Key%20Point%20Detection/) | Trains a convolutional neural network to locate facial keypoints and applies them in an face filter pipeline. | PyTorch, custom `Dataset`, image transforms, CNN model in `models.py`, Haar cascade detectors, saved model checkpoint |
| [Image Style Transfer](the-aiml-playbook/Project%20-%20Image%20Style%20Transfer/) | Recreates neural style transfer using deep VGG19 image features. | PyTorch, VGG19 feature extraction, content/style loss, optimization-based image generation |
| [Object Tracking and Localization](the-aiml-playbook/Project%20-%20Object%20Tracking%20and%20Localization/) | Implements robot sensing, motion, landmark detection, and Graph SLAM in a 2D world. | SLAM, omega/xi constraints, robot simulation, motion and measurement noise, helper visualization |
| [Pneumonia Detection from Chest X-Rays](the-aiml-playbook/Project%20-%20Pneumonia%20Detection%20from%20Chest%20X-Rays/) | Explores chest X-ray metadata, trains a pneumonia classification model, and prepares FDA-style documentation. | Keras, image augmentation, DICOM handling, pydicom, EDA notebook, training/inference notebooks, FDA submission |
| [Sentimental Analysis](the-aiml-playbook/Project%20-%20Sentimental%20Analysis/) | Frames sentiment classification as a neural network problem using review text. | NLP preprocessing, word counts, sentiment ratios, NumPy-based learning workflow |
| [Deploying Sentiment Analysis Model](the-aiml-playbook/Project-%20Deploying%20Sentiment%20Analysis%20Model/) | Builds and deploys a sentiment analysis web app backed by a PyTorch LSTM model on SageMaker. | PyTorch LSTM, SageMaker training and serving scripts, inference handlers, text cleaning utilities, HTML front end |
| [TV Script Generation](the-aiml-playbook/Project-%20TV%20Script%20Generation/) | Generates Seinfeld-style TV scripts from dialogue data. | Recurrent neural networks, sequence modeling, token lookup tables, PyTorch checkpoint |

### The Analytics Mosaic (DataCamp Case Studies)

Located under [the-analytics-mosaic/](the-analytics-mosaic/), these Python projects demonstrate applied data cleaning, exploratory analysis (EDA), and data visualization.

| Case Study | What it analyzes | Data and skills demonstrated |
| --- | --- | --- |
| [A Visual History of Nobel Prize Winners](the-analytics-mosaic/A%20Visual%20History%20of%20Nobel%20Prize%20Winners/) | Nobel Prize winners across year, category, country, gender, organization, and laureate attributes. | Historical EDA, grouped summaries, trend analysis, visualization-ready Nobel dataset |
| [Analyzing Netflix Data](the-analytics-mosaic/Analyzing%20Netflix%20Data/) | Netflix titles by type, release year, country, duration, genre, and metadata. | pandas filtering, content catalog analysis, movie/TV comparison, exploratory visualization |
| [Analyzing TV Data](the-analytics-mosaic/Analyzing%20TV%20Data/) | Super Bowl TV viewership, advertising cost, game outcomes, and halftime musicians. | Joins across multiple CSVs, sports/media analytics, viewer and ad-cost trends |
| [Do Left-handed People Really Die Young?](the-analytics-mosaic/Do%20Left-handed%20People%20Really%20Die%20Young_/) | Project folder for the left-handedness case study; the checked-in dataset is the Iris dataset. | Notebook-based EDA structure, small tabular dataset exploration |
| [Exploring the Evolution of Linux](the-analytics-mosaic/Exploring%20the%20Evolution%20of%20Linux/) | Linux git history using commit timestamps and authors. | Compressed data loading, contribution history analysis, author/activity trends |
| [Name Game: Gender Prediction using Sound](the-analytics-mosaic/Name%20Game_%20Gender%20Prediction%20using%20Sound/) | Predicts likely gender patterns in names using SSA baby names, NYSIIS encodings, and children's book author names. | Phonetic encoding, name normalization, grouped probability features |
| [TV, Halftime Shows, and the Big Game](the-analytics-mosaic/TV,%20Halftime%20Shows,%20and%20the%20Big%20Game/) | Super Bowl game, TV, and halftime performance data. | Multi-table EDA, sports analytics, event and media trend analysis |
| [The Android App Market on Google Play](the-analytics-mosaic/The%20Android%20App%20Market%20on%20Google%20Play/) | Google Play app metadata and user review sentiment. | Data cleaning, category analysis, ratings/reviews exploration, sentiment polarity and subjectivity analysis |
| [The GitHub History of the Scala Language](the-analytics-mosaic/The%20GitHub%20History%20of%20the%20Scala%20Language/) | Scala pull requests, changed files, contributors, and timeline history. | GitHub activity analysis, time series aggregation, contributor/file-level exploration |
| [Who Is Drunk and When in Ames, Iowa?](the-analytics-mosaic/Who%20Is%20Drunk%20and%20When%20in%20Ames,%20Iowa_/) | Breath alcohol test results by date, hour, location, gender, and measurement values. | Time-based EDA, public safety analytics, grouping by hour/location/month |

### StackOverflow Search Engine Project

Located under [stackoverflow-search-engine-project/](stackoverflow-search-engine-project/), this system builds a full web scraper and search engine pipeline.

- [Crawlers](stackoverflow-search-engine-project/crawlers/): Web crawlers developed using Scrapy to scrape questions, answers, and tags from StackExchange sites (specifically Artificial Intelligence, askUbuntu, and Astronomy). Uses SQLAlchemy and PostgreSQL for storage.
- [Engine](stackoverflow-search-engine-project/engine/): A Django-based web application providing a clean search interface over the crawled PostgreSQL database using fulltext search.

---

## Technical Coverage

- **Languages:** Python and SQL
- **Data analysis:** pandas, NumPy, SciPy, Matplotlib, seaborn, scikit-learn, and Dask
- **Deep learning:** PyTorch, torchvision, TensorFlow, and Keras
- **Computer vision:** OpenCV, CNNs, transfer learning, image captioning, keypoint detection, medical imaging, and style transfer
- **NLP and generative AI:** RNNs, LSTMs, Transformers, Hugging Face libraries, LangChain, fine-tuning, and prompt engineering
- **Deployment and MLOps:** Amazon SageMaker, Docker, MLflow, model serving, and simple web interfaces
- **Databases:** PostgreSQL, joins, CTEs, window functions, stored procedures, functions, indexes, SQL analytics, MongoDB, and NoSQL concepts
- **Web Scraping:** Scrapy, XPath/CSS selectors, SQLAlchemy, and crawler pipelines

---

## Using the Repository

Clone the repository and open the project or course directory you want to explore:

```bash
git clone https://github.com/mayank1101/Mayank-AI-Analytics-Lab.git
cd Mayank-AI-Analytics-Lab
```

Most work is notebook-first. There is no repository-wide dependency file because the material spans multiple course generations and framework versions. For executable notebooks:

1. Treat each project or course as an independent environment.
2. Create a virtual environment in that directory.
3. Inspect notebook imports and any local `requirements.txt` before installing packages.
4. Run notebooks in their numbered or documented order.

Some notebooks depend on external datasets, pretrained weights, API credentials, Google Colab, or Amazon SageMaker. Older work may require library versions contemporary with the original course. Review cells before execution, particularly those that download data, invoke paid APIs, or create cloud resources.

---

## Archive Notes

- The repository includes notebooks, source code, SQL scripts, local datasets, exported reports, trained checkpoints, and generated output.
- HTML and PDF exports are retained so results remain viewable when the original runtime is unavailable.
- Large model artifacts are educational outputs and are not guaranteed to be portable across current framework versions.
- Never add API keys, cloud credentials, or populated `.env` files to source control.

---

## License

Original code in this repository is available under the [MIT License](LICENSE). Course material, datasets, certificates, and third-party assets remain subject to the terms and licenses of their respective owners.
