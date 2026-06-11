const CAT_STORAGE_KEY = 'strayCatAdoptionData';

function getCats() {
  const raw = localStorage.getItem(CAT_STORAGE_KEY);
  if (!raw) return [];
  try {
    return JSON.parse(raw);
  } catch (error) {
    console.error('localStorage 解析失败', error);
    return [];
  }
}

function setCats(cats) {
  localStorage.setItem(CAT_STORAGE_KEY, JSON.stringify(cats));
}

function getCatById(id) {
  return getCats().find(cat => cat.id === id) || null;
}

function addCat(cat) {
  const cats = getCats();
  cats.push(cat);
  setCats(cats);
}

function ensureDemoCats() {
  const cats = getCats();
  if (cats.length === 0) {
    const demo = {
      id: '1',
      name: '番薯叶',
      location: '南宁市良庆区南晓镇派双村岽球坡17号',
      lostDate: '2026-04-01',
      desc: '虎纹圆胖，慵懒霸气狸花猫',
      contact: '18776002487',
      imageUrl: 'https://s3.bmp.ovh/2026/06/04/IpMRcZa0.jpg',
      imageBase64: ''
    };
    setCats([demo]);
  }
}

function generateId() {
  return Date.now().toString(36) + Math.random().toString(36).slice(2, 8);
}
