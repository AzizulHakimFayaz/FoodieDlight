# FoodieDelight - Premium Food Ordering App

A modern, high-end food ordering web application built with Flutter.

## ✨ Features
- **Modern Premium Design**: sophisticated typography (*Playfair Display*) and elegant split-hero layout.
- **Creative UI**: Unique "Plate-on-Card" design with 3D depth effects and floating animated backgrounds.
- **Interactive**: Hover effects, micro-animations, and glassmorphism elements.
- **Localized**: Pricing in Bangladeshi Taka (৳).
- **Responsive**: Adapts beautifully to web screens.

## 🚀 How to Run Locally
1.  **Prerequisites**: Ensure you have Flutter installed.
2.  **Clone the repo**:
    ```bash
    git clone https://github.com/AzizulHakimFayaz/FoodieDlight.git
    cd FoodieDlight
    ```
3.  **Install dependencies**:
    ```bash
    flutter pub get
    ```
4.  **Run**:
    ```bash
    flutter run -d chrome
    ```

## 🌐 How to Deploy to GitHub Pages (Live)

To make your website live on GitHub Pages, follow these steps:

### Option 1: Using `flutter build` (Manual Method - Recommended)
1.  **Build the web app**:
    You need to tell Flutter the name of your repository so it knows where to find assets.
    Run this command in your terminal:
    ```bash
    flutter build web --base-href "/FoodieDlight/"
    ```

2.  **Prepare for deployment**:
    *   Create a folder named `docs` in your project root (if you want to use the docs folder method) or just use the `build/web` output.
    *   **Simpler Approach**: We will deploy the `build/web` folder to a `gh-pages` branch.

    **Run these commands one by one:**
    ```bash
    cd build/web
    git init
    git add .
    git commit -m "Deploy to GitHub Pages"
    git branch -M gh-pages
    git remote add origin https://github.com/AzizulHakimFayaz/FoodieDlight.git
    git push -u -f origin gh-pages
    ```

3.  **Configure GitHub**:
    *   Go to your repository on GitHub: [https://github.com/AzizulHakimFayaz/FoodieDlight](https://github.com/AzizulHakimFayaz/FoodieDlight)
    *   Click on **Settings** > **Pages** (on the left sidebar).
    *   Under **Build and deployment** > **Source**, select **Deploy from a branch**.
    *   Under **Branch**, select `gh-pages` and `/ (root)`.
    *   Click **Save**.

4.  **Wait & View**:
    *   Wait a minute or two. GitHub is building your page.
    *   Review the link displayed at the top of the Pages settings (usually `https://azizulhakimfayaz.github.io/FoodieDlight/`).

### Option 2: Using `peanut` (Automated Tool)
You can use a package called `peanut` to handle this automatically.
1.  Install peanut: `dart pub global activate peanut`
2.  Run: `peanut --extra-args "--base-href=/FoodieDlight/"`
3.  Push: `git push origin --set-upstream gh-pages`
4.  Configure GitHub settings as above.

## 📂 Project Structure
- `lib/pages`: Application screens (Home, Order Details).
- `lib/widgets`: Reusable UI components (FoodCard, NavBar).
- `lib/models`: Data models.
- `lib/constants`: App colors and dummy data.
