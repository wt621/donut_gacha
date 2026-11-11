document.addEventListener("DOMContentLoaded", () => {
  const form = document.getElementById("gacha-form");
  const gachaButton = document.getElementById("gacha-button");
  const retryButton = document.getElementById("retry-button");

  const topScreen = document.getElementById("top-screen");
  const loadingScreen = document.getElementById("loading-screen");
  const resultScreen = document.getElementById("result-screen");

  const loadingMessage = document.querySelector(".loading-message");
  const resultList = document.getElementById("gacha-results");
  const resultTemplate = document.getElementById("donut-result-template");

  if (
    !form ||
    !gachaButton ||
    !retryButton ||
    !topScreen ||
    !loadingScreen ||
    !resultScreen ||
    !loadingMessage ||
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

  const displayResults = (donuts) => {
    resultList.replaceChildren();

    donuts.forEach((donut) => {
      const fragment = resultTemplate.content.cloneNode(true);

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
    loadingMessage.textContent = "どのドーナツが当たるかな？";
    resultList.replaceChildren();
    showScreen(loadingScreen);

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

      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.error || "ガチャに失敗しました。");
      }

      if (!Array.isArray(data) || data.length === 0) {
        throw new Error("抽選結果を取得できませんでした。");
      }

      displayResults(data);
      showScreen(resultScreen);
    } catch (error) {
      showScreen(topScreen);
      window.alert(error.message || "通信に失敗しました。もう一度お試しください。");
    } finally {
      gachaButton.disabled = false;
    }
  });

  retryButton.addEventListener("click", () => {
    form.reset();
    resultList.replaceChildren();
    showScreen(topScreen);
  });
});
