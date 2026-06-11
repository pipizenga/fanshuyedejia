function toggleMenu() {
  document.getElementById('main-nav').classList.toggle('active');
}

function createCatCard(cat) {
  const card = document.createElement('div');
  card.className = 'card';
  card.onclick = () => {
    location.href = `detail.html?id=${encodeURIComponent(cat.id)}`;
  };

  const imgSrc = cat.imageUrl || cat.imageBase64 || '';
  if (imgSrc) {
    const wrapper = document.createElement('div');
    wrapper.style.position = 'relative';
    wrapper.style.width = '100%';
    const img = document.createElement('img');
    img.className = 'card-img';
    img.src = imgSrc;
    img.alt = '猫咪照片';
    img.onerror = () => {
      img.style.display = 'none';
      noImg.style.display = 'flex';
    };
    const noImg = document.createElement('div');
    noImg.className = 'no-img';
    noImg.style.display = 'none';
    noImg.innerHTML = '<i class="fas fa-cat fa-4x"></i>';
    wrapper.appendChild(img);
    wrapper.appendChild(noImg);
    card.appendChild(wrapper);
  } else {
    const noImg = document.createElement('div');
    noImg.className = 'no-img';
    noImg.innerHTML = '<i class="fas fa-cat fa-4x"></i>';
    card.appendChild(noImg);
  }

  const info = document.createElement('div');
  info.className = 'card-info';
  info.innerHTML = `
    <h3>${cat.name}</h3>
    <p><i class="fas fa-map-marker-alt"></i> ${cat.location || '未知地点'}</p>
    <p><i class="far fa-calendar-alt"></i> ${cat.lostDate || '未知日期'}</p>
  `;
  card.appendChild(info);
  return card;
}

function renderLatestCats(containerId, limit = 3) {
  ensureDemoCats();
  const cats = getCats();
  const container = document.getElementById(containerId);
  if (!container) return;
  container.innerHTML = '';
  if (cats.length === 0) {
    container.innerHTML = '<p style="text-align:center; color:white;">暂无寻猫启示，<a href="publish.html" style="color:#ffaa66;">点击发布</a></p>';
    return;
  }
  const last3 = cats.slice(-limit).reverse();
  last3.forEach(cat => container.appendChild(createCatCard(cat)));
}

function renderAllCats(containerId) {
  ensureDemoCats();
  const cats = getCats();
  const container = document.getElementById(containerId);
  if (!container) return;
  container.innerHTML = '';
  if (cats.length === 0) {
    container.innerHTML = '<p style="text-align:center; color:white;">暂无寻猫启示，<a href="publish.html" style="color:#ffaa66;">点击发布</a></p>';
    return;
  }
  cats.forEach(cat => container.appendChild(createCatCard(cat)));
}

function renderDetail(catId) {
  const cat = getCatById(catId);
  const container = document.getElementById('detailContainer');
  if (!container) return;
  if (!cat) {
    container.innerHTML = '<p style="text-align:center; color:white;">未找到相关信息。</p>';
    return;
  }
  const imgSrc = cat.imageUrl || cat.imageBase64 || '';
  container.innerHTML = `
    <div class="detail-card">
      <h2>${cat.name}</h2>
      ${imgSrc ? `<div style="position: relative;"><img class="detail-img" src="${imgSrc}" alt="猫咪照片" onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';"><div class="no-img-detail" style="display:none;"><i class='fas fa-cat fa-4x'></i></div></div>` : `<div class='no-img-detail'><i class='fas fa-cat fa-4x'></i></div>`}
      <p><i class="fas fa-map-marker-alt"></i> <strong>丢失地点：</strong> ${cat.location || '暂无'}</p>
      <p><i class="far fa-calendar-alt"></i> <strong>丢失日期：</strong> ${cat.lostDate || '暂无'}</p>
      <p><i class="fas fa-info-circle"></i> <strong>特征描述：</strong> ${cat.desc || '暂无'}</p>
      <p><i class="fas fa-phone-alt"></i> <strong>联系电话：</strong> ${cat.contact || '暂无'}</p>
      <button class="btn btn-primary" style="width:100%;" onclick="window.location.href='tel:${cat.contact}'">📞 联系主人</button>
    </div>
  `;
}

function submitPublishForm(formId, statusId) {
  const form = document.getElementById(formId);
  const status = document.getElementById(statusId);
  if (!form || !status) return;
  form.addEventListener('submit', function (event) {
    event.preventDefault();
    const formData = new FormData(form);
    const cat = {
      id: generateId(),
      name: formData.get('name')?.trim(),
      location: formData.get('location')?.trim(),
      lostDate: formData.get('lostDate')?.trim(),
      desc: formData.get('desc')?.trim(),
      contact: formData.get('contact')?.trim(),
      imageUrl: formData.get('imageUrl')?.trim(),
      imageBase64: formData.get('imageBase64')?.trim()
    };
    if (!cat.name || !cat.contact) {
      status.innerHTML = '<span style="color:#ffaa66;">❌ 请填写猫咪昵称和联系电话</span>';
      return;
    }
    addCat(cat);
    status.innerHTML = '<span style="color:#80ff80;">✅ 发布成功！正在跳转列表页面...</span>';
    setTimeout(() => { location.href = 'list.html'; }, 1200);
  });
}

function handleImageUpload(fileInputId, previewContainerId, imageUrlId, imageBase64Id, statusId) {
  const fileInput = document.getElementById(fileInputId);
  const previewContainer = document.getElementById(previewContainerId);
  const imageUrlField = document.getElementById(imageUrlId);
  const imageBase64Field = document.getElementById(imageBase64Id);
  const status = document.getElementById(statusId);

  if (!fileInput || !previewContainer || !imageUrlField || !imageBase64Field || !status) return;

  fileInput.addEventListener('change', function () {
    const file = this.files[0];
    if (!file) return;

    const reader = new FileReader();
    reader.onload = function (e) {
      previewContainer.innerHTML = `<img src="${e.target.result}" class="preview-img" style="display:block;">`;
      imageBase64Field.value = e.target.result;
      imageUrlField.value = '';
      status.innerHTML = '<span style="color:green;">📷 本地预览已加载，发布后可将此图片直接展示。</span>';
    };
    reader.readAsDataURL(file);
  });
}
