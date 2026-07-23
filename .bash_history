systemctl status mysql     # Ubuntu
systemctl start mysqld
free -h
df -h
free -h                    # 确认 Swap 是 1.0Gi 但 used 是 0
swapon --show              # 若无输出，说明没启用
# 一般已在 /etc/fstab 里，激活：
swapon -a
free -h                    # 再看，Swap used 有值即成
 CHECK_TYPE=SHELL; echo "INFO=${CHECK_TYPE} PID=$$ PPID=$PPID TTY=$(tty) SHELL=$0 HOME=$HOME PWD=$PWD| CHECK_SHELL_END"
bt default
bt5
bt 5
systemctl status mysqld    # CentOS
# 或
systemctl status mysql     # Ubuntu
node -e "console.log(require('crypto').randomBytes(24).toString('hex'))"
systemctl status mysqld    # CentOS
# 或
systemctl status mysql     # Ubuntu
systemctl status mysqld    # CentOS
# 或
systemctl status mysql     # Ubuntu
systemctl status mysqld    # CentOS
ss -tlnp | grep 3306
node -e "console.log(require('crypto').randomBytes(24).toString('hex'))"
pm2 restart eichen-site --update-env
cd /www/wwwroot/yichenshangwu.com/mingyuan-consulting
pm2 restart eichen-site --update-env
 MAKRER=SHOW_LOCALE;printf $MAKRER""; locale; MAKRER=SHOW_LOCALE;printf $MAKRER"";
 CHECK_TYPE=SHELL; echo "INFO=${CHECK_TYPE} PID=$$ PPID=$PPID TTY=$(tty) SHELL=$0 HOME=$HOME PWD=$PWD| CHECK_SHELL_END"
bt 5
cd /www/wwwroot/yichenshangwu.com/mingyuan-consulting
npm install better-sqlite3 --registry=https://registry.npmmirror.com --save
ls node_modules/better-sqlite3/build/Release/*.node
tail -3 server.js
cd /www/wwwroot/yichenshangwu.com/mingyuan-consulting
cat > server.js <<'ENDOFFILE'
const express = require('express');
const path = require('path');
const fs = require('fs');
const { renderServicePage, SERVICES } = require('./services');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'public')));

const DB_PATH = process.env.DB_PATH || path.join(__dirname, 'data', 'inquiries.db');

let db = null;
function initDb() {
  try {
    fs.mkdirSync(path.dirname(DB_PATH), { recursive: true });
    const Database = require('better-sqlite3');
    db = new Database(DB_PATH);
    db.pragma('journal_mode = WAL');
    db.exec(`
      CREATE TABLE IF NOT EXISTS inquiries (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        company TEXT,
        phone TEXT,
        email TEXT,
        service TEXT,
        message TEXT,
        source TEXT,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    `);
    const cols = db.prepare("PRAGMA table_info(inquiries)").all();
    if (!cols.some((c) => c.name === 'source')) {
      db.exec("ALTER TABLE inquiries ADD COLUMN source TEXT");
    }
    console.log('[DB] SQLite ready at ' + DB_PATH);
  } catch (err) {
    console.error('[DB] init failed:', err.message);
    db = null;
  }
}

app.get('/service/:slug', (req, res) => {
  const service = SERVICES[req.params.slug];
  if (!service) return res.status(404).send('Service not found');
  res.set('Content-Type', 'text/html; charset=utf-8');
  res.send(renderServicePage(service));
});

app.post('/api/contact', (req, res) => {
  const { name, company, phone, email, service, message, source } = req.body || {};
  if (!name || !(phone || email)) {
    return res.status(400).json({ ok: false, error: '请填写姓名以及联系方式（电话或邮箱）。' });
  }
  const src = (source || 'main-form').toString().slice(0, 40);
  try {
    if (db) {
      db.prepare(
        'INSERT INTO inquiries (name, company, phone, email, service, message, source) VALUES (?, ?, ?, ?, ?, ?, ?)'
      ).run(name, company || null, phone || null, email || null, service || null, message || null, src);
    } else {
      console.log('[Inquiry preview]', { name, company, phone, email, service, message, source: src });
    }
    res.json({ ok: true });
  } catch (err) {
    console.error('[DB] insert failed:', err);
    res.status(500).json({ ok: false, error: '服务器繁忙，请稍后再试。' });
  }
});

app.get('/api/inquiries', (req, res) => {
  const token = req.query.token;
  if (!token || token !== (process.env.ADMIN_TOKEN || 'eichen-admin')) {
    return res.status(403).json({ ok: false, error: 'forbidden' });
  }
  if (!db) return res.json({ ok: true, data: [], note: 'preview mode' });
  const rows = db
    .prepare('SELECT id, name, company, phone, email, service, message, source, created_at FROM inquiries ORDER BY id DESC LIMIT 200')
    .all();
  res.json({ ok: true, data: rows });
});

app.get('/admin', (req, res) => res.redirect(302, '/admin.html'));
app.get('/health', (req, res) => res.json({ ok: true }));

initDb();
app.listen(PORT, '0.0.0.0', () => {
  console.log('EICHEN site running on http://0.0.0.0:' + PORT);
});
ENDOFFILE

node -e "console.log(require('crypto').randomBytes(24).toString('hex'))"
pm2 restart eichen-site --update-env
pm2 logs eichen-site --lines 15 --nostream
cd /www/wwwroot/yichenshangwu.com/mingyuan-consulting
grep -c "mysql\|sqlite\|better-sqlite3" server.js
head -5 server.js
pm2 info eichen-site | grep -E "script|cwd|exec cwd"
cd /www/wwwroot/yichenshangwu.com/mingyuan-consulting
pm2 delete eichen-site
pm2 start ecosystem.config.js
pm2 save
pm2 logs eichen-site --lines 15 --nostream
ls node_modules/better-sqlite3/build/Release/*.node 2>&1
cd /www/wwwroot/yichenshangwu.com/mingyuan-consulting
grep -E "require\('(mysql|better-sqlite)" server.js
ls node_modules/better-sqlite3/build/Release/ 2>&1
cd /www/wwwroot/yichenshangwu.com/mingyuan-consulting
pm2 delete eichen-site
pm2 flush                       # 清空所有历史日志
pm2 start ecosystem.config.js
pm2 save
pm2 logs eichen-site --lines 20 --nostream
curl -X POST http://127.0.0.1:3000/api/contact   -H "Content-Type: application/json"   -d '{"name":"测试","phone":"13800000000","message":"服务器测试","source":"main-form"}'
node -e "const db=require('better-sqlite3')('data/inquiries.db'); console.log(db.prepare('SELECT * FROM inquiries').all())"
cd /www/wwwroot/yichenshangwu.com/mingyuan-consulting
# 1. 完全删掉 PM2 里的进程
pm2 delete eichen-site
# 2. 清空所有历史日志（这一步很关键！）
pm2 flush
rm -f /root/.pm2/logs/eichen-site-*.log
# 3. 确认 server.js 确实是 SQLite 版
grep -n "mysql" server.js
pm2 start ecosystem.config.js
pm2 save
sleep 2
# 只看启动后新产生的输出
cat /root/.pm2/logs/eichen-site-out.log
# 提交一条测试数据
curl -X POST http://127.0.0.1:3000/api/contact   -H "Content-Type: application/json"   -d '{"name":"测试","phone":"13800000000","message":"sqlite测试"}'
# 立刻看是否有新错误
cat /root/.pm2/logs/eichen-site-error.log
cd /www/wwwroot/yichenshangwu.com/mingyuan-consulting
pm2 start ecosystem.config.js
pm2 save
sleep 2
cat /root/.pm2/logs/eichen-site-out.log
curl -I http://127.0.0.1:3000/
curl -s http://127.0.0.1:3000/health
curl -X POST http://127.0.0.1:3000/api/contact   -H "Content-Type: application/json"   -d '{"name":"测试","phone":"13800000000","message":"sqlite测试","source":"main-form"}'
node -e "console.log(require('better-sqlite3')('data/inquiries.db').prepare('SELECT * FROM inquiries').all())"
mkdir -p /root/backup
cp /www/wwwroot/yichenshangwu.com/mingyuan-consulting/data/inquiries.db    /root/backup/inquiries.$(date +%F).db
find /root/backup -name 'inquiries.*.db' -mtime +30 -delete
cd /www/wwwroot/yichenshangwu.com/mingyuan-consulting
grep -c 'id="consult-fab"' public/index.html
grep -c 'id="consult-close"' public/index.html
grep -c 'consult-form' public/index.html
grep -c 'id="consult"' public/script.js
curl -sI http://127.0.0.1:3000/script.js | head -3
grep -c "consult-fab" /www/wwwroot/yichenshangwu.com/mingyuan-consulting/public/script.js
curl -sI http://127.0.0.1:3000/script.js | head -3
curl -s http://127.0.0.1:3000/script.js | grep -c "consult-fab"
cd /www/wwwroot/yichenshangwu.com/mingyuan-consulting
cat > public/script.js <<'ENDOFFILE'
(function () {
  const $ = (sel, ctx = document) => ctx.querySelector(sel);
  const $$ = (sel, ctx = document) => Array.from(ctx.querySelectorAll(sel));

  const yearEl = document.getElementById('year');
  if (yearEl) yearEl.textContent = new Date().getFullYear();

  const nav = document.getElementById('nav');
  const onScroll = () => {
    if (!nav) return;
    if (window.scrollY > 30) nav.classList.add('is-scrolled');
    else nav.classList.remove('is-scrolled');
  };
  window.addEventListener('scroll', onScroll, { passive: true });
  onScroll();

  const navToggle = $('.nav__toggle');
  const navLinks = $('.nav__links');
  if (navToggle && navLinks) {
    navToggle.addEventListener('click', () => {
      const isOpen = navLinks.style.display === 'flex';
      if (isOpen) {
        navLinks.removeAttribute('style');
      } else {
        Object.assign(navLinks.style, {
          display: 'flex', flexDirection: 'column', position: 'absolute',
          top: '64px', right: '22px', background: 'rgba(6,16,31,0.96)',
          padding: '20px 28px', border: '1px solid rgba(255,255,255,0.08)', gap: '16px'
        });
      }
    });
    navLinks.addEventListener('click', (e) => {
      if (e.target.tagName === 'A' && window.innerWidth <= 680) {
        navLinks.removeAttribute('style');
      }
    });
  }

  const io = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        entry.target.classList.add('is-in');
        io.unobserve(entry.target);
      }
    });
  }, { threshold: 0.12, rootMargin: '0px 0px -60px 0px' });
  $$('.reveal').forEach((el) => io.observe(el));

  const stagger = (selector, step = 90) => {
    $$(selector).forEach((el, i) => { el.style.transitionDelay = `${i * step}ms`; });
  };
  stagger('.services .service', 80);
  stagger('.cases .case', 120);
  stagger('.team .member', 100);
  stagger('.hero__stats > div', 120);

  const form = document.getElementById('inquiry-form');
  const notice = document.getElementById('form-notice');
  if (form) {
    form.addEventListener('submit', async (e) => {
      e.preventDefault();
      notice.className = 'form__notice';
      notice.textContent = '正在提交…';
      const data = Object.fromEntries(new FormData(form).entries());
      if (!data.phone && !data.email) {
        notice.className = 'form__notice is-err';
        notice.textContent = '请至少填写电话或邮箱中的一项。';
        return;
      }
      try {
        const r = await fetch('/api/contact', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(data),
        });
        const json = await r.json();
        if (json.ok) {
          notice.className = 'form__notice is-ok';
          notice.textContent = '✓ 已收到您的咨询请求，我们的顾问将在 2 个工作日内主动与您联系。';
          form.reset();
        } else {
          notice.className = 'form__notice is-err';
          notice.textContent = json.error || '提交失败，请稍后再试。';
        }
      } catch (err) {
        notice.className = 'form__notice is-err';
        notice.textContent = '网络异常，请稍后再试。';
      }
    });
  }

  const consult = document.getElementById('consult');
  const fab = document.getElementById('consult-fab');
  const closeBtn = document.getElementById('consult-close');
  const backdrop = document.getElementById('consult-backdrop');
  const wechatBtn = document.getElementById('consult-wechat');
  const consultForm = document.getElementById('consult-form');
  const consultNotice = document.getElementById('consult-notice');

  if (consult && fab) {
    const open = () => {
      consult.classList.add('is-open');
      document.body.style.overflow = 'hidden';
    };
    const close = () => {
      consult.classList.remove('is-open');
      document.body.style.overflow = '';
    };
    fab.addEventListener('click', open);
    closeBtn && closeBtn.addEventListener('click', close);
    backdrop && backdrop.addEventListener('click', close);
    document.addEventListener('keydown', (e) => {
      if (e.key === 'Escape' && consult.classList.contains('is-open')) close();
    });
  }

  if (wechatBtn) {
    wechatBtn.addEventListener('click', () => {
      const txt = '135 4400 4101';
      try {
        if (navigator.clipboard) {
          navigator.clipboard.writeText(txt);
          alert('微信号已复制：' + txt + '\n请打开微信，搜索并添加好友。');
        } else {
          alert('请添加微信：' + txt);
        }
      } catch (e) {
        alert('请添加微信：' + txt);
      }
    });
  }

  if (consultForm) {
    consultForm.addEventListener('submit', async (e) => {
      e.preventDefault();
      consultNotice.className = 'consult__notice';
      consultNotice.textContent = '正在提交…';
      const data = Object.fromEntries(new FormData(consultForm).entries());
      if (!data.name || !data.phone) {
        consultNotice.className = 'consult__notice is-err';
        consultNotice.textContent = '请填写姓名和电话。';
        return;
      }
      try {
        const r = await fetch('/api/contact', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ ...data, source: 'consult-widget' }),
        });
        const json = await r.json();
        if (json.ok) {
          consultNotice.className = 'consult__notice is-ok';
          consultNotice.textContent = '✓ 已收到，EIDON 顾问将在 1 个工作日内联系您。';
          consultForm.reset();
        } else {
          consultNotice.className = 'consult__notice is-err';
          consultNotice.textContent = json.error || '提交失败，请稍后再试。';
        }
      } catch (err) {
        consultNotice.className = 'consult__notice is-err';
        consultNotice.textContent = '网络异常，请稍后再试。';
      }
    });
  }
})();
ENDOFFILE

cd /www/wwwroot/yichenshangwu.com/mingyuan-consulting
cat > public/script.js <<'ENDOFFILE'
(function () {
  const $ = (sel, ctx = document) => ctx.querySelector(sel);
  const $$ = (sel, ctx = document) => Array.from(ctx.querySelectorAll(sel));

  const yearEl = document.getElementById('year');
  if (yearEl) yearEl.textContent = new Date().getFullYear();

  const nav = document.getElementById('nav');
  const onScroll = () => {
    if (!nav) return;
    if (window.scrollY > 30) nav.classList.add('is-scrolled');
    else nav.classList.remove('is-scrolled');
  };
  window.addEventListener('scroll', onScroll, { passive: true });
  onScroll();

  const navToggle = $('.nav__toggle');
  const navLinks = $('.nav__links');
  if (navToggle && navLinks) {
    navToggle.addEventListener('click', () => {
      const isOpen = navLinks.style.display === 'flex';
      if (isOpen) {
        navLinks.removeAttribute('style');
      } else {
        Object.assign(navLinks.style, {
          display: 'flex', flexDirection: 'column', position: 'absolute',
          top: '64px', right: '22px', background: 'rgba(6,16,31,0.96)',
          padding: '20px 28px', border: '1px solid rgba(255,255,255,0.08)', gap: '16px'
        });
      }
    });
    navLinks.addEventListener('click', (e) => {
      if (e.target.tagName === 'A' && window.innerWidth <= 680) {
        navLinks.removeAttribute('style');
      }
    });
  }

  const io = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        entry.target.classList.add('is-in');
        io.unobserve(entry.target);
      }
    });
  }, { threshold: 0.12, rootMargin: '0px 0px -60px 0px' });
  $$('.reveal').forEach((el) => io.observe(el));

  const stagger = (selector, step = 90) => {
    $$(selector).forEach((el, i) => { el.style.transitionDelay = `${i * step}ms`; });
  };
  stagger('.services .service', 80);
  stagger('.cases .case', 120);
  stagger('.team .member', 100);
  stagger('.hero__stats > div', 120);

  const form = document.getElementById('inquiry-form');
  const notice = document.getElementById('form-notice');
  if (form) {
    form.addEventListener('submit', async (e) => {
      e.preventDefault();
      notice.className = 'form__notice';
      notice.textContent = '正在提交…';
      const data = Object.fromEntries(new FormData(form).entries());
      if (!data.phone && !data.email) {
        notice.className = 'form__notice is-err';
        notice.textContent = '请至少填写电话或邮箱中的一项。';
        return;
      }
      try {
        const r = await fetch('/api/contact', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(data),
        });
        const json = await r.json();
        if (json.ok) {
          notice.className = 'form__notice is-ok';
          notice.textContent = '✓ 已收到您的咨询请求，我们的顾问将在 2 个工作日内主动与您联系。';
          form.reset();
        } else {
          notice.className = 'form__notice is-err';
          notice.textContent = json.error || '提交失败，请稍后再试。';
        }
      } catch (err) {
        notice.className = 'form__notice is-err';
        notice.textContent = '网络异常，请稍后再试。';
      }
    });
  }

  const consult = document.getElementById('consult');
  const fab = document.getElementById('consult-fab');
  const closeBtn = document.getElementById('consult-close');
  const backdrop = document.getElementById('consult-backdrop');
  const wechatBtn = document.getElementById('consult-wechat');
  const consultForm = document.getElementById('consult-form');
  const consultNotice = document.getElementById('consult-notice');

  if (consult && fab) {
    const open = () => {
      consult.classList.add('is-open');
      document.body.style.overflow = 'hidden';
    };
    const close = () => {
      consult.classList.remove('is-open');
      document.body.style.overflow = '';
    };
    fab.addEventListener('click', open);
    closeBtn && closeBtn.addEventListener('click', close);
    backdrop && backdrop.addEventListener('click', close);
    document.addEventListener('keydown', (e) => {
      if (e.key === 'Escape' && consult.classList.contains('is-open')) close();
    });
  }

  if (wechatBtn) {
    wechatBtn.addEventListener('click', () => {
      const txt = '135 4400 4101';
      try {
        if (navigator.clipboard) {
          navigator.clipboard.writeText(txt);
          alert('微信号已复制：' + txt + '\n请打开微信，搜索并添加好友。');
        } else {
          alert('请添加微信：' + txt);
        }
      } catch (e) {
        alert('请添加微信：' + txt);
      }
    });
  }

  if (consultForm) {
    consultForm.addEventListener('submit', async (e) => {
      e.preventDefault();
      consultNotice.className = 'consult__notice';
      consultNotice.textContent = '正在提交…';
      const data = Object.fromEntries(new FormData(consultForm).entries());
      if (!data.name || !data.phone) {
        consultNotice.className = 'consult__notice is-err';
        consultNotice.textContent = '请填写姓名和电话。';
        return;
      }
      try {
        const r = await fetch('/api/contact', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ ...data, source: 'consult-widget' }),
        });
        const json = await r.json();
        if (json.ok) {
          consultNotice.className = 'consult__notice is-ok';
          consultNotice.textContent = '✓ 已收到，EIDON 顾问将在 1 个工作日内联系您。';
          consultForm.reset();
        } else {
          consultNotice.className = 'consult__notice is-err';
          consultNotice.textContent = json.error || '提交失败，请稍后再试。';
        }
      } catch (err) {
        consultNotice.className = 'consult__notice is-err';
        consultNotice.textContent = '网络异常，请稍后再试。';
      }
    });
  }
})();
ENDOFFILE

grep -c "consult-fab" public/script.js
tail -3 public/script.js
grep -c "consult-fab" public/script.js
tail -3 public/script.js
cd /www/wwwroot/yichenshangwu.com/mingyuan-consulting
cat > public/script.js <<'ENDOFFILE'
(function () {
  const $ = (sel, ctx = document) => ctx.querySelector(sel);
  const $$ = (sel, ctx = document) => Array.from(ctx.querySelectorAll(sel));

  const yearEl = document.getElementById('year');
  if (yearEl) yearEl.textContent = new Date().getFullYear();

  const nav = document.getElementById('nav');
  const onScroll = () => {
    if (!nav) return;
    if (window.scrollY > 30) nav.classList.add('is-scrolled');
    else nav.classList.remove('is-scrolled');
  };
  window.addEventListener('scroll', onScroll, { passive: true });
  onScroll();

  const navToggle = $('.nav__toggle');
  const navLinks = $('.nav__links');
  if (navToggle && navLinks) {
    navToggle.addEventListener('click', () => {
      const isOpen = navLinks.style.display === 'flex';
      if (isOpen) {
        navLinks.removeAttribute('style');
      } else {
        Object.assign(navLinks.style, {
          display: 'flex', flexDirection: 'column', position: 'absolute',
          top: '64px', right: '22px', background: 'rgba(6,16,31,0.96)',
          padding: '20px 28px', border: '1px solid rgba(255,255,255,0.08)', gap: '16px'
        });
      }
    });
    navLinks.addEventListener('click', (e) => {
      if (e.target.tagName === 'A' && window.innerWidth <= 680) {
        navLinks.removeAttribute('style');
      }
    });
  }

  const io = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        entry.target.classList.add('is-in');
        io.unobserve(entry.target);
      }
    });
  }, { threshold: 0.12, rootMargin: '0px 0px -60px 0px' });
  $$('.reveal').forEach((el) => io.observe(el));

  const stagger = (selector, step = 90) => {
    $$(selector).forEach((el, i) => { el.style.transitionDelay = `${i * step}ms`; });
  };
  stagger('.services .service', 80);
  stagger('.cases .case', 120);
  stagger('.team .member', 100);
  stagger('.hero__stats > div', 120);

  const form = document.getElementById('inquiry-form');
  const notice = document.getElementById('form-notice');
  if (form) {
    form.addEventListener('submit', async (e) => {
      e.preventDefault();
      notice.className = 'form__notice';
      notice.textContent = '正在提交…';
      const data = Object.fromEntries(new FormData(form).entries());
      if (!data.phone && !data.email) {
        notice.className = 'form__notice is-err';
        notice.textContent = '请至少填写电话或邮箱中的一项。';
        return;
      }
      try {
        const r = await fetch('/api/contact', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(data),
        });
        const json = await r.json();
        if (json.ok) {
          notice.className = 'form__notice is-ok';
          notice.textContent = '✓ 已收到您的咨询请求，我们的顾问将在 2 个工作日内主动与您联系。';
          form.reset();
        } else {
          notice.className = 'form__notice is-err';
          notice.textContent = json.error || '提交失败，请稍后再试。';
        }
      } catch (err) {
        notice.className = 'form__notice is-err';
        notice.textContent = '网络异常，请稍后再试。';
      }
    });
  }

  const consult = document.getElementById('consult');
  const fab = document.getElementById('consult-fab');
  const closeBtn = document.getElementById('consult-close');
  const backdrop = document.getElementById('consult-backdrop');
  const wechatBtn = document.getElementById('consult-wechat');
  const consultForm = document.getElementById('consult-form');
  const consultNotice = document.getElementById('consult-notice');

  if (consult && fab) {
    const open = () => {
      consult.classList.add('is-open');
      document.body.style.overflow = 'hidden';
    };
    const close = () => {
      consult.classList.remove('is-open');
      document.body.style.overflow = '';
    };
    fab.addEventListener('click', open);
    closeBtn && closeBtn.addEventListener('click', close);
    backdrop && backdrop.addEventListener('click', close);
    document.addEventListener('keydown', (e) => {
      if (e.key === 'Escape' && consult.classList.contains('is-open')) close();
    });
  }

  if (wechatBtn) {
    wechatBtn.addEventListener('click', () => {
      const txt = '135 4400 4101';
      try {
        if (navigator.clipboard) {
          navigator.clipboard.writeText(txt);
          alert('微信号已复制：' + txt + '\n请打开微信，搜索并添加好友。');
        } else {
          alert('请添加微信：' + txt);
        }
      } catch (e) {
        alert('请添加微信：' + txt);
      }
    });
  }

  if (consultForm) {
    consultForm.addEventListener('submit', async (e) => {
      e.preventDefault();
      consultNotice.className = 'consult__notice';
      consultNotice.textContent = '正在提交…';
      const data = Object.fromEntries(new FormData(consultForm).entries());
      if (!data.name || !data.phone) {
        consultNotice.className = 'consult__notice is-err';
        consultNotice.textContent = '请填写姓名和电话。';
        return;
      }
      try {
        const r = await fetch('/api/contact', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ ...data, source: 'consult-widget' }),
        });
        const json = await r.json();
        if (json.ok) {
          consultNotice.className = 'consult__notice is-ok';
          consultNotice.textContent = '✓ 已收到，EIDON 顾问将在 1 个工作日内联系您。';
          consultForm.reset();
        } else {
          consultNotice.className = 'consult__notice is-err';
          consultNotice.textContent = json.error || '提交失败，请稍后再试。';
        }
      } catch (err) {
        consultNotice.className = 'consult__notice is-err';
        consultNotice.textContent = '网络异常，请稍后再试。';
      }
    });
  }
})();
ENDOFFILE

grep -c "consult-fab" public/script.js
tail -3 public/script.js
cd /www/wwwroot/yichenshangwu.com/mingyuan-consulting
wc -l public/script.js
grep -n "ENDOFFILE" public/script.js
head -3 public/script.js
cd /www/wwwroot/yichenshangwu.com/mingyuan-consulting
cat >> public/styles.css <<'ENDOFFILE'

/* Hide online consult widget */
.consult { display: none !important; }
ENDOFFILE

/www/server/panel/BTPanel/templates/default/
[200~ls /www/server/panel/vhost/cert/~
ls /www/server/panel/vhost/cert/
ls /www/server/panel/vhost/cert/yichenshangwu.com/
ls /www/server/panel/vhost/cert/www.yichenshangwu.com/
curl -I http://47.119.126.187/
curl -kI https://47.119.126.187/
ls /www/server/panel/vhost/cert/
ls /www/server/panel/vhost/cert/yichenshangwu.com/
ssl_certificate     /www/server/panel/vhost/cert/yichenshangwu.com/fullchain.pem;
    ssl_certificate_key /www/server/panel/vhost/cert/yichenshangwu.com/privkey.pem
ls /www/server/panel/vhost/cert/yichenshangwu.com/
ls /www/server/panel/vhost/cert/
curl -I http://47.119.126.187/
curl -kI https://47.119.126.187/
curl -I http://47.119.126.187/
curl -kI https://47.119.126.187/
ls -la /www/server/panel/vhost/cert/yichenshangwu.com/
[200~grep -A 5 "default_server" /www/server/panel/vhost/nginx/*.conf~
grep -A 5 "default_server" /www/server/panel/vhost/nginx/*.conf
[200~grep -rn "default_server" /www/server/panel/vhost/nginx/~
grep -rn "default_server" /www/server/panel/vhost/nginx/
nginx -t
nginx -s reload
curl -I http://47.119.126.187/
curl -kI https://47.119.126.187/
curl -I -H "Cache-Control: no-cache" http://47.119.126.187/
systemctl restart nginx
grep -rn "default_server" /www/server/panel/vhost/nginx/
nginx -t                # 测试语法
nginx -s reload         # 重载
curl -I http://47.119.126.187/
[200~nginx -t
nginx -s reload~
nginx -t
nginx -s reload
curl -I http://47.119.126.187/
curl -kI https://47.119.126.187/
nginx -t
nginx -s reload
curl -I http://47.119.126.187/
curl -kI https://47.119.126.187/
curl -I https://www.yichenshangwu.com/
cd /www/wwwroot/yichenshangwu.com/mingyuan-consulting
pm2 restart eichen-site
curl -H 'Content-Type:text/plain' --data-binary @- "http://data.zz.baidu.com/urls?site=https://www.yichenshangwu.com&token=你的Token" <<EOF
https://www.yichenshangwu.com/
https://www.yichenshangwu.com/service/hk
https://www.yichenshangwu.com/service/overseas
https://www.yichenshangwu.com/service/bank
https://www.yichenshangwu.com/service/tax
https://www.yichenshangwu.com/service/ip
https://www.yichenshangwu.com/service/change
EOF

curl -H 'Content-Type:text/plain' --data-binary @- "http://data.zz.baidu.com/urls?site=https://www.yichenshangwu.com&token=你的Token" <<EOF
https://www.yichenshangwu.com/
https://www.yichenshangwu.com/service/hk
https://www.yichenshangwu.com/service/overseas
https://www.yichenshangwu.com/service/bank
https://www.yichenshangwu.com/service/tax
https://www.yichenshangwu.com/service/ip
https://www.yichenshangwu.com/service/change
EOF

curl -H 'Content-Type:text/plain' --data-binary @- http://data.zz.baidu.com/urls?site=https://yichenshangwu.com&token=rqHOh4BpV2xGYD41 <<EOF
https://www.yichenshangwu.com/
https://www.yichenshangwu.com/service/hk
https://www.yichenshangwu.com/service/overseas
https://www.yichenshangwu.com/service/bank
https://www.yichenshangwu.com/service/tax
https://www.yichenshangwu.com/service/ip
https://www.yichenshangwu.com/service/change
EOF

curl -H 'Content-Type:text/plain' --data-binary @- http://data.zz.baidu.com/urls?site=https://yichenshangwu.com&token=rqHOh4BpV2xGYD41 <<EOF
https://www.yichenshangwu.com/
https://www.yichenshangwu.com/service/hk
https://www.yichenshangwu.com/service/overseas
https://www.yichenshangwu.com/service/bank
https://www.yichenshangwu.com/service/tax
https://www.yichenshangwu.com/service/ip
https://www.yichenshangwu.com/service/change
EOF

kill %1 %2 2>/dev/null
curl -H 'Content-Type:text/plain' --data-binary @- "http://data.zz.baidu.com/urls?site=https://yichenshangwu.com&token=rqHOh4BpV2xGYD41" <<'EOF'
https://www.yichenshangwu.com/
https://www.yichenshangwu.com/service/hk
https://www.yichenshangwu.com/service/overseas
https://www.yichenshangwu.com/service/bank
https://www.yichenshangwu.com/service/tax
https://www.yichenshangwu.com/service/ip
https://www.yichenshangwu.com/service/change
EOF

curl -H 'Content-Type:text/plain' --data-binary @- "http://data.zz.baidu.com/urls?site=https://yichenshangwu.com&token=rqHOh4BpV2xGYD41" <<'EOF'
https://yichenshangwu.com/
https://yichenshangwu.com/service/hk
https://yichenshangwu.com/service/overseas
https://yichenshangwu.com/service/bank
https://yichenshangwu.com/service/tax
https://yichenshangwu.com/service/ip
https://yichenshangwu.com/service/change
EOF

[200~cd /www/wwwroot/yichenshangwu.com
curl -H 'Content-Type:text/plain' --data-binary @urls.txt "http://data.zz.baidu.com/urls?site=yichenshangwu.com&token=rqHOh4BpV2xGYD41"~cd /www/wwwroot/yichenshangwu.com
curl -H 'Content-Type:text/plain' --data-binary @urls.txt "http://data.zz.baidu.com/urls?site=yichenshangwu.com&token=rqHOh4BpV2xGYD41"
[200~cd /www/wwwroot/yichenshangwu.com
curl -H 'Content-Type:text/plain' --data-binary @urls.txt "http://data.zz.baidu.com/urls?site=yichenshangwu.com&token=rqHOh4BpV2xGYD41"~cd /www/wwwroot/yichenshangwu.com
curl -H 'Content-Type:text/plain' --data-binary @urls.txt "http://data.zz.baidu.com/urls?site=yichenshangwu.com&token=rqHOh4BpV2xGYD41"
ls -la /www/wwwroot/yichenshangwu.com/urls.txt
cd /www/wwwroot/yichenshangwu.com
curl -H 'Content-Type:text/plain' --data-binary @urls.txt "http://data.zz.baidu.com/urls?site=yichenshangwu.com&token=rqHOh4BpV2xGYD41"
ls -la /www/wwwroot/yichenshangwu.com/urls.txt
ls -la /www/wwwroot/yichenshangwu.com/
curl -H 'Content-Type:text/plain' --data-binary @/www/wwwroot/yichenshangwu.com/urls.txt "http://data.zz.baidu.com/urls?site=yichenshangwu.com&token=rqHOh4BpV2xGYD41"
ls -la /www/wwwroot/yichenshangwu.com/
curl -H 'Content-Type:text/plain' --data-binary @/www/wwwroot/yichenshangwu.com/urls.txt "http://data.zz.baidu.com/urls?site=yichenshangwu.com&token=rqHOh4BpV2xGYD41"
# 修改前（错误）
curl -H 'Content-Type:text/plain' --data-binary @/www/wwwroot/yichenshangwu.com/urls.txt "http://data.zz.baidu.com/urls?site=https://yichenshangwu.com&token=rqHOh4BpV2xGYD41"
# 修改后（正确）
curl -H 'Content-Type:text/plain' --data-binary @/www/wwwroot/yichenshangwu.com/urls.txt "http://data.zz.baidu.com/urls?site=yichenshangwu.com&token=rqHOh4BpV2xGYD41"
curl -H 'Content-Type:text/plain' --data-binary @urls.txt "http://data.zz.baidu.com/urls?site=https://yichenshangwu.com&token=rqHOh4BpV2xGYD41"
curl -H 'Content-Type:text/plain' --data-binary @/www/wwwroot/yichenshangwu.com/urls.txt "http://data.zz.baidu.com/urls?site=yichenshangwu.com&token=rqHOh4BpV2xGYD41"
curl -H 'Content-Type:text/plain' --data-binary @urls.txt "http://data.zz.baidu.com/urls?site=https://yichenshangwu.com&token=rqHOh4BpV2xGYD41"
curl -H 'Content-Type:text/plain' --data-binary @/www/wwwroot/yichenshangwu.com/urls.txt "http://data.zz.baidu.com/urls?site=yichenshangwu.com&token=rqHOh4BpV2xGYD41"
curl -H 'Content-Type:text/plain' --data-binary @urls.txt "http://data.zz.baidu.com/urls?site=https://yichenshangwu.com&token=rqHOh4BpV2xGYD41"
pwd
ls -l urls.txt
curl -H 'Content-Type:text/plain' --data-binary @/www/wwwroot/yichenshangwu.com/urls.txt "http://data.zz.baidu.com/urls?site=https://yichenshangwu.com&token=rqHOh4BpV2xGYD41"
cd /root
cat > urls.txt <<'EOF'
https://yichenshangwu.com/
https://yichenshangwu.com/about
EOF

curl -H 'Content-Type:text/plain'   --data-binary @urls.txt   "http://data.zz.baidu.com/urls?site=https://yichenshangwu.com&token=rqHOh4BpV2xGYD41"
find / -name "urls.txt" 2>/dev/null
curl -H 'Content-Type:text/plain'   --data-binary @/www/wwwroot/yichenshangwu.com/urls.txt   "http://data.zz.baidu.com/urls?site=https://yichenshangwu.com&token=你的token"
rm /root/urls.txt
{     "remain": 99998,     // 当天剩余，从满额减少;     "success": 2,        // 本次成功;     "not_same_site": [], // 域名不匹配被丢弃;     "not_valid": []      // 格式错误; }
curl -H 'Content-Type:text/plain'   --data-binary @/www/wwwroot/yichenshangwu.com/urls.txt   "http://data.zz.baidu.com/urls?site=https://yichenshangwu.com&token=新token"
curl -H 'Content-Type:text/plain'   --data-binary @/www/wwwroot/yichenshangwu.com/urls.txt   "http://data.zz.baidu.com/urls?site=https://yichenshangwu.com&token=rqHOh4BpV2xGYD41"
api.indexnow.org
curl -H 'Content-Type:text/plain' --data-binary @/www/wwwroot/yichenshangwu.com/urls.txt "http://data.zz.baidu.com/urls?site=yichenshangwu.com&token=rqHOh4BpV2xGYD41"
# 查看根目录html文件
ls -la /www/wwwroot/yichenshangwu.com/*.html
# 查看service目录
ls -la /www/wwwroot/yichenshangwu.com/service/*.html
# 查看blog目录
ls -la /www/wwwroot/yichenshangwu.com/blog/*.html
curl -X POST "https://api.indexnow.org/IndexNow"   -H "Content-Type: application/json; charset=utf-8"   -d '{
    "host": "yichenshangwu.com",
    "key": "d771f44933fe4aabbf42f45ee588e8b7",
    "keyLocation": "https://yichenshangwu.com/你的API密钥.txt",
    "urlList": [
      "https://yichenshangwu.com/",
      "https://yichenshangwu.com/blog/hongkong-bank-account-opening-guide.html"
    ]
  }'
curl -X POST "https://api.indexnow.org/IndexNow"   -H "Content-Type: application/json; charset=utf-8"   -d '{
    "host": "yichenshangwu.com",
    "key": "d0c38a430b4b4f949cbd2e14d8476eb0",
    "keyLocation": "https://yichenshangwu.com/d0c38a430b4b4f949cbd2e14d8476eb0.txt",
    "urlList": [
      "https://yichenshangwu.com/",
      "https://yichenshangwu.com/blog/hongkong-bank-account-opening-guide.html"
    ]
  }'
POST /IndexNow HTTP/1.1
Content-Type: application/json; charset=utf-8
Host: api.indexnow.org
{   "host": "www.example.org",;   "key": "d0c38a430b4b4f949cbd2e14d8476eb0",;   "keyLocation": "https://www.example.org/d0c38a430b4b4f949cbd2e14d8476eb0.txt",;   "urlList": [;       "https://www.example.org/url1",;       "https://www.example.org/folder/url2",;       "https://www.example.org/url3";       ]; }
curl -X POST "https://api.indexnow.org/IndexNow"   -H "Content-Type: application/json; charset=utf-8"   -d '{
    "host": "yichenshangwu.com",
    "key": "d0c38a430b4b4f949cbd2e14d8476eb0",
    "keyLocation": "https://yichenshangwu.com/d0c38a430b4b4f949cbd2e14d8476eb0.txt",
    "urlList": [
      "https://yichenshangwu.com/",
      "https://yichenshangwu.com/blog/hongkong-bank-account-opening-guide.html"
    ]
  }'
curl -X POST "https://api.indexnow.org/IndexNow"   -H "Content-Type: application/json; charset=utf-8"   -d '{
    "host": "yichenshangwu.com",
    "key": "d0c38a430b4b4f949cbd2e14d8476eb0",
    "keyLocation": "https://yichenshangwu.com/d0c38a430b4b4f949cbd2e14d8476eb0.txt",
    "urlList": [
      "https://yichenshangwu.com/",
      "https://yichenshangwu.com/blog/hongkong-bank-account-opening-guide.html"
    ]
  }'
curl -X POST "https://api.indexnow.org/IndexNow"   -H "Content-Type: application/json; charset=utf-8"   -d '{
    "host": "yichenshangwu.com",
    "key": "d0c38a430b4b4f949cbd2e14d8476eb0",
    "keyLocation": "https://yichenshangwu.com/d0c38a430b4b4f949cbd2e14d8476eb0.txt",
    "urlList": [
      "https://yichenshangwu.com/",
      "https://yichenshangwu.com/blog/hongkong-bank-account-opening-guide.html"
    ]
  }'
curl -X POST "https://api.indexnow.org/IndexNow"   -H "Content-Type: application/json; charset=utf-8"   -d '{
    "host": "yichenshangwu.com",
    "key": "d0c38a430b4b4f949cbd2e14d8476eb0",
    "keyLocation": "https://yichenshangwu.com/d0c38a430b4b4f949cbd2e14d8476eb0.txt",
    "urlList": [
      "https://yichenshangwu.com/",
      "https://yichenshangwu.com/blog/hongkong-bank-account-opening-guide.html"
    ]
  }'
curl -v -X POST "https://api.indexnow.org/IndexNow"   -H "Content-Type: application/json; charset=utf-8"   -d '{
    "host": "yichenshangwu.com",
    "key": "d0c38a430b4b4f949cbd2e14d8476eb0",
    "keyLocation": "https://yichenshangwu.com/d0c38a430b4b4f949cbd2e14d8476eb0.txt",
    "urlList": [
      "https://yichenshangwu.com/",
      "https://yichenshangwu.com/blog/hongkong-bank-account-opening-guide.html"
    ]
  }'   -w "\n\n✅ HTTP 状态码: %{http_code}\n"
curl -X POST "https://api.indexnow.org/IndexNow"   -H "Content-Type: application/json; charset=utf-8"   -d '{
    "host": "yichenshangwu.com",
    "key": "d0c38a430b4b4f949cbd2e14d8476eb0",
    "keyLocation": "https://yichenshangwu.com/d0c38a430b4b4f949cbd2e14d8476eb0.txt",
    "urlList": ["https://yichenshangwu.com/blog/hk-annual-review-overdue-guide.html"]
  }'
curl -X POST "https://api.indexnow.org/IndexNow"   -H "Content-Type: application/json; charset=utf-8"   -d '{
    "host": "yichenshangwu.com",
    "key": "d0c38a430b4b4f949cbd2e14d8476eb0",
    "keyLocation": "https://yichenshangwu.com/d0c38a430b4b4f949cbd2e14d8476eb0.txt",
    "urlList": ["https://yichenshangwu.com/blog/hk-annual-review-overdue-guide.html"]
  }'
curl -X POST "https://api.indexnow.org/IndexNow"   -H "Content-Type: application/json; charset=utf-8"   -d '{
    "host": "yichenshangwu.com",
    "key": "d0c38a430b4b4f949cbd2e14d8476eb0",
    "keyLocation": "https://yichenshangwu.com/d0c38a430b4b4f949cbd2e14d8476eb0.txt",
    "urlList": ["https://yichenshangwu.com/blog/hk-annual-review-overdue-guide.html"]
  }'   -w "\n\n✅ HTTP 状态码: %{http_code}\n"
curl -X POST "https://api.indexnow.org/IndexNow"   -H "Content-Type: application/json; charset=utf-8"   -d '{
    "host": "yichenshangwu.com",
    "key": "d0c38a430b4b4f949cbd2e14d8476eb0",
    "keyLocation": "https://yichenshangwu.com/d0c38a430b4b4f949cbd2e14d8476eb0.txt",
    "urlList": ["https://yichenshangwu.com/"]
  }'   -w "\n\n📊 HTTP 状态码: %{http_code}\n"
curl -X POST "https://api.indexnow.org/IndexNow"   -H "Content-Type: application/json; charset=utf-8"   -d '{
    "host": "yichenshangwu.com",
    "key": "d0c38a430b4b4f949cbd2e14d8476eb0",
    "keyLocation": "https://yichenshangwu.com/d0c38a430b4b4f949cbd2e14d8476eb0.txt",
    "urlList": ["https://yichenshangwu.com/blog/singapore-tax-guide.html"]
  }' 
[200~curl -X POST "https://api.indexnow.org/IndexNow"   -H "Content-Type: application/json; charset=utf-8"   -d '{
    "host": "yichenshangwu.com",
    "key": "d0c38a430b4b4f949cbd2e14d8476eb0",
    "keyLocation": "https://yichenshangwu.com/d0c38a430b4b4f949cbd2e14d8476eb0.txt",
    "urlList": ["https://yichenshangwu.com/blog/singapore-tax-guide.html"]
  }'~
[200~curl -X POST "https://api.indexnow.org/IndexNow"   -H "Content-Type: application/json; charset=utf-8"   -d '{
    "host": "yichenshangwu.com",
    "key": "d0c38a430b4b4f949cbd2e14d8476eb0",
    "keyLocation": "https://yichenshangwu.com/d0c38a430b4b4f949cbd2e14d8476eb0.txt",
    "urlList": ["https://yichenshangwu.com/blog/singapore-tax-guide.html"]
  }'~curl -X POST "https://api.indexnow.org/IndexNow"   -H "Content-Type: application/json; charset=utf-8"   -d '{
    "host": "yichenshangwu.com",
    "key": "d0c38a430b4b4f949cbd2e14d8476eb0",
    "keyLocation": "https://yichenshangwu.com/d0c38a430b4b4f949cbd2e14d8476eb0.txt",
    "urlList": ["https://yichenshangwu.com/blog/singapore-tax-guide.html"]
  }'
curl -X POST "https://api.indexnow.org/IndexNow"   -H "Content-Type: application/json; charset=utf-8"   -d '{
    "host": "yichenshangwu.com",
    "key": "d0c38a430b4b4f949cbd2e14d8476eb0",
    "keyLocation": "https://yichenshangwu.com/d0c38a430b4b4f949cbd2e14d8476eb0.txt",
    "urlList": ["https://yichenshangwu.com/blog/singapore-tax-guide.html"]
  }'
clear
cd /www/wwwroot/yichenshangwu.com/en
curl -X POST "https://api.indexnow.org/IndexNow"   -H "Content-Type: application/json; charset=utf-8"   -d '{
    "host": "yichenshangwu.com",
    "key": "d0c38a430b4b4f949cbd2e14d8476eb0",
    "keyLocation": "https://yichenshangwu.com/d0c38a430b4b4f949cbd2e14d8476eb0.txt",
    "urlList": ["https://yichenshangwu.com/"]
  }'
git init
