<h1>Fall 2023 Rutgers University Datathon Submission: Most Accurate Forecasting Model</h1>
<h1>Fall 2023 Rutgers University Datathon Submission: Most Accurate Forecasting Model</h1>

<p>In Fall 2023, I participated in the Rutgers University Data Science Club Datathon, a competition that challenged participants to develop accurate forecasting models. Using data provided by NOAA, which recorded monthly temperature anomalies from 1850 to 2022, I successfully built the most accurate forecasting model and won the datathon. This experience not only marked my first project in R but also served as an incredible introduction to the language and its capabilities.</p>

<h2>The Challenge</h2>

<p>The datathon tasked participants with predicting temperature anomalies, requiring the application of data science, time series forecasting, and machine learning techniques. As someone new to R and predictive analytics, I embraced the challenge and committed to learning on the go. The competition provided a perfect platform to experiment with various forecasting methods and gain hands-on experience.</p>

<h2>Exploration of Methods</h2>

<p>To identify the most effective model, I explored a range of prediction techniques, including:</p>
<ul>
<li><strong>Native methods</strong> (e.g., ARIMA and STL decomposition)</li>
<li><strong>Statistical models</strong> (e.g., ANOVA)</li>
<li><strong>Machine learning models</strong>, such as neural networks (<code>nnet</code>) and Support Vector Machines (<code>e1071</code>).</li>
</ul>

<p>Ultimately, I chose <strong>XGBoost</strong>, a gradient-boosted decision tree library, as it delivered the most accurate and consistent performance. Its ability to handle non-linear relationships and capture complex patterns in the dataset proved invaluable.</p>

<h2>Why XGBoost?</h2>

<p>XGBoost stood out due to its robustness and flexibility in tuning hyperparameters. Through iterative experimentation and cross-validation, I optimized the model to minimize error metrics, including <strong>Cross-Validation Mean Absolute Percentage Error (CV_MAPE)</strong>, Mean Absolute Error (MAE), and Root Mean Square Error (RMSE). These metrics helped validate the model's accuracy and reliability in the forecasting task.</p>

<h2>Process and Insights</h2>

<p>My approach involved several key steps:</p>
<ol>
<li>Preprocessed the dataset to ensure stationarity and suitability for modeling.</li>
<li>Experimented with multiple forecasting techniques to understand their strengths and limitations.</li>
<li>Fine-tuned XGBoost hyperparameters to achieve the best possible predictive performance.</li>
</ol>

<p>The XGBoost model excelled in minimizing error rates and produced a highly accurate forecast, which ultimately secured the win. Despite some challenges in interpreting the flat trend in the later years of the forecast, the model's overall accuracy was unmatched.</p>

<h2>Learning Outcomes</h2>

<p>This datathon was an incredible learning experience and a rewarding introduction to R. As my first project in the language, it pushed me to quickly familiarize myself with R’s capabilities and apply them effectively. From data preprocessing to model selection and hyperparameter tuning, I gained valuable insights into the intricacies of time series forecasting and machine learning.</p>

<p>Winning the datathon with the most accurate forecasting model was a proud moment and a testament to the hard work and determination I invested in the project. More importantly, this experience has sparked a strong interest in data science and predictive analytics, which I look forward to exploring further in future projects.</p>

<p>If you have any questions about these projects or are interested in collaborating on future projects, I’d love to hear from you! Connect with me on <a href="https://www.linkedin.com/in/alexander-mandryk/" target="_blank">LinkedIn</a>.</p>
