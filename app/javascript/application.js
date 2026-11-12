document.addEventListener("DOMContentLoaded", () => {
  const form = document.getElementById("gacha-form");
  const gachaButton = document.getElementById("gacha-button");
  const retryButton = document.getElementById("retry-button");

  const topScreen = document.getElementById("top-screen");
  const loadingScreen = document.getElementById("loading-screen");
  const resultScreen = document.getElementById("result-screen");

  const loadingImage = document.getElementById("donut-choice-image");
  const resultList = document.getElementById("gacha-results");
  const resultTemplate = document.getElementById("donut-result-template");

  const closedImagePreloader = new Image();
  closedImagePreloader.src = loadingImage.dataset.closedImage;

  const closedImageReady = closedImagePreloader.decode().catch(() => {});

  if (
    !form ||
    !gachaButton ||
    !retryButton ||
    !topScreen ||
    !loadingScreen ||
    !resultScreen ||
    !loadingImage ||
    !resultList ||
    !resultTemplate
  ) {
    return;
  }

  const showScreen = (screen) => {
    [topScreen, loadingScreen, resultScreen].forEach((item) => {
      item.hidden = item !== screen;
    });
  };

  const groupClassNames = {
    pie: "result-card--pie",
    "pon-de": "result-card--pon-de",
    "old-fashion": "result-card--old-fashion",
    french: "result-card--french",
    yeast: "result-card--yeast",
    chocolate: "result-card--chocolate",
    variety: "result-card--variety",
    muffin: "result-card--muffin",
    "allergy-free": "result-card--allergy-free",
  };

  const displayResults = (donuts) => {
    resultList.replaceChildren();

    donuts.forEach((donut) => {
      const fragment = resultTemplate.content.cloneNode(true);
      const resultCard = fragment.querySelector(".result-card");

      resultCard.classList.add(
        groupClassNames[donut.group_name] || "result-card--default"
      );

      fragment.querySelector("[data-result-name]").textContent = donut.name;
      fragment.querySelector("[data-result-group]").textContent =
        donut.group_name;
      fragment.querySelector("[data-result-price]").textContent = donut.price;

      resultList.appendChild(fragment);
    });
  };

  form.addEventListener("submit", async (event) => {
    event.preventDefault();

    if (gachaButton.disabled) return;

    gachaButton.disabled = true;

    await closedImageReady;

    const animationStartedAt = Date.now();
    const openImage = loadingImage.dataset.openImage;
    const closedImage = loadingImage.dataset.closedImage;

    resultList.replaceChildren();
    showScreen(loadingScreen);

    // トングの開閉アニメーションを開始
    let isOpen = true;
    loadingImage.src = openImage;

    const animationTimer = window.setInterval(() => {
      isOpen = !isOpen;
      loadingImage.src = isOpen ? openImage : closedImage;
    }, 350);

    try {
      let donuts;
      let requestError;

      try {
        const csrfToken = document.querySelector(
          'meta[name="csrf-token"]'
        )?.content;

        const response = await fetch(form.action, {
          method: "POST",
          headers: {
            Accept: "application/json",
            "X-CSRF-Token": csrfToken || "",
          },
          body: new FormData(form),
          credentials: "same-origin",
        });

        let data;

        try {
          data = await response.json();
        } catch {
          throw new Error("サーバーから正しい応答を受け取れませんでした。");
        }

        if (!response.ok) {
          throw new Error(data.error || "ガチャに失敗しました。");
        }

        if (!Array.isArray(data) || data.length === 0) {
          throw new Error("抽選結果を取得できませんでした。");
        }

        donuts = data;
      } catch (error) {
        requestError = error;
      }

      // 抽選開始から最低2秒間はアニメーションを表示
      const elapsedTime = Date.now() - animationStartedAt;
      const remainingTime = Math.max(0, 2000 - elapsedTime);

      await new Promise((resolve) => {
        window.setTimeout(resolve, remainingTime);
      });

      if (requestError) {
        throw requestError;
      }

      displayResults(donuts);
      showScreen(resultScreen);
    } catch (error) {
      showScreen(topScreen);

      window.alert(
        error.message || "通信に失敗しました。もう一度お試しください。"
      );
    } finally {
      window.clearInterval(animationTimer);

      // アニメーション終了後は開いた画像に戻す
      loadingImage.src = openImage;

      gachaButton.disabled = false;
    }
  });

  retryButton.addEventListener("click", () => {
    form.reset();
    resultList.replaceChildren();
    showScreen(topScreen);
  });
});
