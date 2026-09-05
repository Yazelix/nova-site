use kinestra::{Error, Recorder, Result, Size};
use std::{
    env, fs,
    os::unix::fs::symlink,
    path::{Path, PathBuf},
    process::{Command, ExitCode, Stdio},
    time::Duration,
};

#[derive(Clone, Copy, PartialEq, Eq)]
enum Variant {
    Original,
    Session,
    Sixty,
    Popups,
    Appearance,
    Yazi,
    Live,
    Anima,
}

impl Variant {
    fn parse(name: &str) -> Result<Self> {
        match name {
            "original" => Ok(Self::Original),
            "session" => Ok(Self::Session),
            "sixty" => Ok(Self::Sixty),
            "popups" => Ok(Self::Popups),
            "appearance" => Ok(Self::Appearance),
            "yazi" => Ok(Self::Yazi),
            "live" => Ok(Self::Live),
            "anima" => Ok(Self::Anima),
            _ => Err(Error::Invalid(format!("unknown take: {name}"))),
        }
    }
    fn media(self) -> (&'static str, Duration) {
        let (stem, offset) = match self {
            Self::Original => ("nova-day-to-day", 9.0),
            Self::Session => ("nova-day-to-day-session", 8.0),
            Self::Sixty => ("nova-in-60-seconds", 1.6),
            Self::Popups => ("nova-popups", 2.0),
            Self::Appearance => ("nova-appearance", 4.0),
            Self::Yazi => ("nova-yazi", 3.0),
            Self::Live => ("nova-live", 6.0),
            Self::Anima => ("nova-anima", 9.0),
        };
        (stem, seconds(offset))
    }
    fn play(self, r: &mut Recorder) -> Result<()> {
        match self {
            Self::Original => play_original(r),
            Self::Session => play_session(r),
            Self::Sixty => play_sixty(r),
            Self::Popups => play_popups(r),
            Self::Appearance => play_appearance(r),
            Self::Yazi => play_yazi(r),
            Self::Live => play_live(r),
            Self::Anima => play_anima(r),
        }
    }
}

fn seconds(value: f64) -> Duration {
    Duration::from_secs_f64(value)
}
fn key(r: &mut Recorder, chord: &str, delay: f64) -> Result<()> {
    r.key(chord, seconds(delay))
}
fn type_text(r: &mut Recorder, text: &str) -> Result<()> {
    r.type_text(text, Duration::from_millis(45))
}

fn play_original(r: &mut Recorder) -> Result<()> {
    r.sleep(seconds(0.80))?;
    key(r, "alt+shift+l", 3.00)?;
    key(r, "alt+2", 1.20)?;
    key(r, "ctrl+t", 0.35)?;
    key(r, "n", 1.20)?;
    key(r, "ctrl+y", 0.40)?;
    key(r, "alt+z", 0.80)?;
    r.type_text("anima", Duration::from_millis(45))?;
    key(r, "Return", 2.00)?;
    r.type_text("src/boids.rs", Duration::from_millis(45))?;
    key(r, "Return", 1.80)?;
    key(r, "alt+r", 1.20)?;
    key(r, "j", 0.25)?;
    key(r, "Return", 1.80)?;
    key(r, "ctrl+alt+h", 0.80)?;
    key(r, "alt+shift+h", 1.00)?;
    key(r, "alt+h", 1.00)?;
    key(r, "alt+l", 1.00)?;
    key(r, "alt+shift+h", 0.80)?;
    key(r, "alt+m", 1.40)?;
    key(r, "ctrl+alt+k", 0.80)?;
    key(r, "alt+shift+k", 2.00)?;
    key(r, "5", 0.80)?;
    key(r, "a", 0.80)?;
    key(r, "slash", 0.20)?;
    r.type_text("rounded", Duration::from_millis(45))?;
    key(r, "Return", 0.80)?;
    key(r, "space", 0.40)?;
    key(r, "Return", 1.40)?;
    key(r, "space", 0.40)?;
    key(r, "Return", 1.40)?;
    key(r, "Escape", 0.20)?;
    key(r, "Escape", 1.00)?;
    key(r, "alt+1", 2.50)?;
    key(r, "alt+shift+l", 0.80)?;
    key(r, "alt+2", 0.80)?;
    key(r, "alt+shift+b", 3.20)?;
    key(r, "Return", 0.70)?;
    key(r, "alt+1", 1.20)?;
    Ok(())
}

fn play_session(r: &mut Recorder) -> Result<()> {
    r.sleep(seconds(6.00))?;
    key(r, "alt+shift+l", 5.00)?;
    key(r, "alt+2", 3.00)?;
    key(r, "ctrl+t", 0.35)?;
    key(r, "n", 2.50)?;
    key(r, "ctrl+y", 1.00)?;
    key(r, "alt+z", 2.00)?;
    r.type_text("anima", Duration::from_millis(45))?;
    key(r, "Return", 3.50)?;
    r.type_text("src/boids.rs", Duration::from_millis(45))?;
    key(r, "Return", 3.50)?;
    key(r, "alt+r", 2.50)?;
    key(r, "j", 0.80)?;
    key(r, "Return", 3.00)?;
    key(r, "ctrl+alt+h", 1.50)?;
    key(r, "alt+shift+h", 2.50)?;
    key(r, "alt+h", 2.50)?;
    key(r, "alt+l", 2.50)?;
    key(r, "alt+shift+h", 2.00)?;
    key(r, "alt+m", 2.50)?;
    key(r, "ctrl+alt+k", 1.50)?;
    key(r, "alt+shift+k", 3.50)?;
    key(r, "5", 2.00)?;
    key(r, "a", 2.00)?;
    key(r, "slash", 0.40)?;
    r.type_text("rounded", Duration::from_millis(45))?;
    key(r, "Return", 1.50)?;
    key(r, "space", 0.60)?;
    key(r, "Return", 2.50)?;
    key(r, "space", 0.60)?;
    key(r, "Return", 2.50)?;
    r.sleep(seconds(2.00))?;
    key(r, "q", 2.00)?;
    key(r, "alt+1", 3.00)?;
    key(r, "alt+shift+l", 6.00)?;
    key(r, "alt+2", 2.00)?;
    key(r, "alt+shift+b", 5.00)?;
    key(r, "Return", 1.00)?;
    r.sleep(seconds(4.00))?;
    key(r, "alt+1", 3.00)?;
    Ok(())
}

fn play_sixty(r: &mut Recorder) -> Result<()> {
    r.sleep(seconds(3.40))?;
    key(r, "alt+shift+b", 0.85)?;
    key(r, "alt+2", 0.85)?;
    key(r, "alt+1", 1.00)?;
    key(r, "alt+shift+l", 1.20)?;
    r.type_text(
        "what's special about yazelix nova, for someone who never used it before? under 2048 chars",
        Duration::from_millis(80),
    )?;
    key(r, "Return", 0.90)?;
    key(r, "alt+3", 0.70)?;
    key(r, "ctrl+y", 1.00)?;
    r.sleep(seconds(0.45))?;
    key(r, "j", 0.65)?;
    r.sleep(seconds(0.40))?;
    key(r, "l", 1.20)?;
    r.sleep(seconds(0.50))?;
    key(r, "j", 0.55)?;
    key(r, "j", 0.60)?;
    r.sleep(seconds(0.50))?;
    key(r, "Return", 1.80)?;
    r.sleep(seconds(0.40))?;
    key(r, "space", 0.30)?;
    key(r, "f", 1.00)?;
    r.type_text("lib.rs", Duration::from_millis(45))?;
    r.sleep(seconds(0.45))?;
    key(r, "Return", 1.50)?;
    key(r, "alt+r", 1.60)?;
    key(r, "alt+z", 1.60)?;
    r.type_text("anima", Duration::from_millis(45))?;
    key(r, "Return", 2.50)?;
    r.type_text("src/matrix.rs", Duration::from_millis(45))?;
    r.sleep(seconds(0.45))?;
    key(r, "Return", 2.00)?;
    key(r, "ctrl+alt+h", 0.75)?;
    key(r, "ctrl+alt+h", 0.75)?;
    key(r, "ctrl+alt+l", 0.75)?;
    key(r, "ctrl+alt+l", 0.80)?;
    key(r, "alt+shift+h", 0.70)?;
    key(r, "alt+m", 1.00)?;
    r.type_text("yzx --version", Duration::from_millis(45))?;
    key(r, "Return", 1.10)?;
    key(r, "alt+m", 1.00)?;
    r.type_text("ls src", Duration::from_millis(45))?;
    key(r, "Return", 1.10)?;
    key(r, "alt+m", 1.00)?;
    r.type_text("git log -1 --oneline", Duration::from_millis(45))?;
    key(r, "Return", 1.10)?;
    key(r, "alt+k", 0.45)?;
    key(r, "alt+k", 0.45)?;
    key(r, "alt+j", 0.45)?;
    key(r, "alt+j", 0.45)?;
    key(r, "ctrl+alt+j", 1.00)?;
    key(r, "alt+shift+h", 0.80)?;
    key(r, "alt+shift+k", 2.00)?;
    key(r, "5", 0.80)?;
    key(r, "a", 0.80)?;
    key(r, "slash", 0.20)?;
    r.type_text("rounded", Duration::from_millis(45))?;
    key(r, "Return", 0.80)?;
    key(r, "space", 0.40)?;
    key(r, "Return", 1.40)?;
    key(r, "space", 0.40)?;
    key(r, "Return", 1.40)?;
    key(r, "alt+shift+k", 0.70)?;
    key(r, "alt+1", 4.50)?;
    Ok(())
}

fn play_popups(r: &mut Recorder) -> Result<()> {
    r.sleep(seconds(0.90))?;
    key(r, "alt+shift+y", 1.10)?;
    key(r, "j", 0.30)?;
    key(r, "j", 0.30)?;
    key(r, "k", 0.30)?;
    r.sleep(seconds(2.00))?;
    key(r, "alt+shift+y", 0.70)?;
    key(r, "alt+shift+j", 4.40)?;
    key(r, "alt+shift+j", 0.80)?;
    Ok(())
}

fn play_yazi(r: &mut Recorder) -> Result<()> {
    r.sleep(seconds(1.80))?;
    key(r, "alt+r", 1.60)?;
    key(r, "k", 0.45)?;
    r.sleep(seconds(1.80))?;
    key(r, "Return", 2.20)?;
    Ok(())
}

fn play_live(r: &mut Recorder) -> Result<()> {
    r.sleep(seconds(1.80))?;
    key(r, "alt+shift+h", 1.40)?;
    r.sleep(seconds(1.00))?;
    key(r, "alt+shift+h", 1.40)?;
    r.sleep(seconds(0.80))?;
    key(r, "alt+m", 1.00)?;
    r.type_text("yzx --version", Duration::from_millis(45))?;
    key(r, "Return", 1.10)?;
    key(r, "alt+m", 1.00)?;
    r.type_text("ls src", Duration::from_millis(45))?;
    key(r, "Return", 1.10)?;
    key(r, "alt+m", 1.00)?;
    r.type_text("git log -1 --oneline", Duration::from_millis(45))?;
    key(r, "Return", 1.10)?;
    key(r, "alt+k", 0.50)?;
    key(r, "alt+k", 0.50)?;
    key(r, "alt+j", 0.50)?;
    key(r, "alt+j", 0.50)?;
    key(r, "ctrl+alt+j", 1.50)?;
    r.sleep(seconds(1.40))?;
    key(r, "alt+shift+b", 5.00)?;
    Ok(())
}

fn play_anima(r: &mut Recorder) -> Result<()> {
    r.sleep(seconds(1.80))?;
    key(r, "alt+shift+b", 3.80)?;
    key(r, "alt+shift+b", 0.90)?;
    r.sleep(seconds(0.50))?;
    key(r, "alt+shift+n", 4.80)?;
    Ok(())
}

fn play_appearance(r: &mut Recorder) -> Result<()> {
    r.sleep(seconds(1.80))?;
    key(r, "alt+shift+k", 1.80)?;
    key(r, "5", 1.00)?;
    r.sleep(seconds(0.50))?;
    key(r, "space", 0.55)?;
    for _ in 0..13 {
        key(r, "j", 0.12)?;
    }
    key(r, "space", 0.40)?;
    key(r, "Return", 2.80)?;
    key(r, "space", 0.55)?;
    for _ in 0..13 {
        key(r, "k", 0.12)?;
    }
    key(r, "space", 0.40)?;
    key(r, "Return", 2.80)?;
    key(r, "Escape", 0.80)?;
    Ok(())
}

fn clone_at(
    r: &mut Recorder,
    sources: &Path,
    name: &str,
    revision: &str,
    branch: &str,
) -> Result<()> {
    let destination = sources.join(name);
    if !destination.join(".git").is_dir() {
        r.exec(
            Command::new("git")
                .args(["clone", "--filter=blob:none", "--no-checkout"])
                .arg(format!("https://github.com/Yazelix/{name}.git"))
                .arg(&destination),
        )?;
    }
    r.exec(
        Command::new("git")
            .arg("-C")
            .arg(&destination)
            .args(["fetch", "--depth", "1", "origin", revision]),
    )?;
    r.exec(Command::new("git").arg("-C").arg(destination).args([
        "checkout",
        "--force",
        "-B",
        branch,
        "FETCH_HEAD",
    ]))
}

fn prepare_tabs(r: &mut Recorder, variant: Variant) -> Result<()> {
    key(r, "alt+m", 0.8)?;
    let (editor, tab) = if variant == Variant::Sixty {
        ("hx AGENTS.md", "nova")
    } else {
        ("hx src/render.rs", "ratconfig")
    };
    type_text(r, editor)?;
    key(r, "Return", 4.0)?;
    key(r, "ctrl+t", 0.35)?;
    key(r, "r", 0.35)?;
    type_text(r, tab)?;
    key(r, "Return", 1.0)?;
    key(r, "ctrl+t", 0.35)?;
    key(r, "n", 2.2)?;
    key(r, "ctrl+y", 0.6)?;
    key(r, "alt+z", 1.5)?;
    type_text(r, "starcompass")?;
    key(r, "Return", 4.5)?;
    type_text(r, "src/starcompass.rs")?;
    key(r, "Return", 3.5)?;
    if variant == Variant::Sixty {
        key(r, "ctrl+t", 0.35)?;
        key(r, "n", 2.2)?;
        key(r, "ctrl+y", 0.6)?;
        key(r, "alt+z", 1.5)?;
        type_text(r, "anima")?;
        key(r, "Return", 4.5)?;
        type_text(r, "src/boids.rs")?;
        key(r, "Return", 3.5)?;
        key(r, "alt+shift+b", 2.0)?;
    } else {
        key(r, "alt+1", 1.2)?;
    }
    Ok(())
}

fn record(r: &mut Recorder, variant: Variant) -> Result<()> {
    let root = env::current_dir()?;
    let script = root.join("drafts/recordings");
    let sources = script.join(".work/sources");
    let output = root.join("drafts/media");
    let public = root.join("public/blog/yazelix-nova-v1/media");
    let wallpaper = script.join("partenoxenese-blue-faro.jpg");
    if !wallpaper.is_file() {
        return Err(Error::Invalid(format!(
            "missing recording input: {}",
            wallpaper.display()
        )));
    }
    let nova = PathBuf::from(
        r.output(Command::new("nix").args([
            "build",
            "--no-link",
            "--print-out-paths",
            "github:Yazelix/nova/5a673c059c454042085b191d5e8ec15c01b3d121",
        ]))?
        .trim(),
    );
    let closure = r.output(Command::new("nix-store").arg("-qR").arg(&nova))?;
    let find = |suffix: &str| -> Result<PathBuf> {
        closure
            .lines()
            .find(|line| {
                if suffix == "-mars" {
                    line.ends_with(suffix)
                } else {
                    line.rsplit_once("-zellij-").is_some_and(|(_, version)| {
                        version.starts_with(|c: char| c.is_ascii_digit())
                    })
                }
            })
            .map(PathBuf::from)
            .ok_or_else(|| Error::Invalid(format!("missing {suffix} in Nova closure")))
    };
    let mars = find("-mars")?;
    let zellij = find("-zellij-")?;
    let work = r.work().to_path_buf();
    for directory in [
        &sources,
        &output,
        &public,
        &work.join("state"),
        &work.join("zoxide"),
        &work.join("atuin"),
    ] {
        fs::create_dir_all(directory)?;
    }
    clone_at(
        r,
        &sources,
        "ratconfig",
        "675a21f17900df47585b2a8290c5436204d120e4",
        "main",
    )?;
    clone_at(
        r,
        &sources,
        "starcompass",
        "621bc6fcec916521c116e89d1ae8b146973145d5",
        "edge",
    )?;
    clone_at(
        r,
        &sources,
        "anima",
        "ea6cbedd3e5e9292b5d730003a5a9020389451f2",
        "main",
    )?;
    for branch in ["edge", "stable"] {
        r.exec(
            Command::new("git")
                .arg("-C")
                .arg(sources.join("anima"))
                .args(["branch", "-f", branch]),
        )?;
    }
    r.exec(
        Command::new("cp")
            .arg("-R")
            .arg(script.join("config"))
            .arg(work.join("config")),
    )?;
    fs::write(
        work.join("atuin/config.toml"),
        format!(
            "db_path = {:?}\nauto_sync = false\nupdate_check = false\n",
            work.join("atuin/history.db").to_string_lossy()
        ),
    )?;
    let product = root.join("../nova").canonicalize()?;
    let config = work.join("config/config.toml");
    fs::write(
        &config,
        fs::read_to_string(&config)?
            .replace("__NOVA_SITE_REPO_ROOT__", &root.to_string_lossy())
            .replace("__NOVA_PRODUCT_REPO__", &product.to_string_lossy()),
    )?;
    symlink(&sources, work.join("sources"))?;
    for (path, score) in [
        (&root, "8"),
        (&sources.join("ratconfig"), "8"),
        (&sources.join("starcompass"), "8"),
        (&sources.join("anima"), "8"),
        (&product, "20"),
    ] {
        r.exec(
            Command::new("zoxide")
                .args(["add", "--score", score])
                .arg(path)
                .env("_ZO_DATA_DIR", work.join("zoxide")),
        )?;
    }
    r.display(Size::new(1784, 996)?, Some(&wallpaper))?;
    let session = format!("nova-site-recording-{}", std::process::id());
    let mut cleanup = Command::new(zellij.join("bin/zellij"));
    cleanup
        .args(["delete-session", "--force", &session])
        .stdout(Stdio::null())
        .stderr(Stdio::null());
    r.on_exit(cleanup);
    let path = env::join_paths(
        std::iter::once(nova.join("bin"))
            .chain(env::split_paths(&env::var_os("PATH").unwrap_or_default())),
    )
    .map_err(|error| Error::Invalid(error.to_string()))?;
    r.launch(
        "yzx",
        Command::new(nova.join("bin/yzx"))
            .args(["launch", "--session", &session])
            .env("YAZELIX_CONFIG_HOME", work.join("config"))
            .env("YAZELIX_STATE_DIR", work.join("state"))
            .env("_ZO_DATA_DIR", work.join("zoxide"))
            .env("ATUIN_CONFIG_DIR", work.join("atuin"))
            .env("PATH", &path)
            .current_dir(if variant == Variant::Sixty {
                product.clone()
            } else {
                sources.join("ratconfig")
            }),
    )?;
    r.sleep(seconds(12.0))?;
    prepare_tabs(r, variant)?;
    let (stem, offset) = variant.media();
    r.record(&work.join(format!("{stem}.mp4")), |r| variant.play(r))?;
    r.stop_app()?;

    let mut files = vec![format!("{stem}.mp4"), format!("{stem}-poster.png")];
    if variant == Variant::Original {
        fs::create_dir_all(work.join("ratconfig"))?;
        r.launch(
            "nova-ratconfig",
            Command::new(mars.join("bin/mars"))
                .args(["--title-placeholder", "nova-ratconfig", "-e"])
                .arg(nova.join("bin/yzx"))
                .arg("config")
                .env("MARS_APP_ID", "nova-ratconfig")
                .env("MARS_CONFIG_HOME", script.join("config/mars"))
                .env("MARS_BASE_CONFIG_HOME", mars.join("share/mars"))
                .env("YAZELIX_CURSOR_CONFIG", script.join("config/cursors.toml"))
                .env("YAZELIX_CONFIG_HOME", work.join("ratconfig"))
                .env("PATH", &path),
        )?;
        r.sleep(seconds(3.0))?;
        r.snapshot(&work.join("ratconfig-nova-v1.png"))?;
        r.stop_app()?;
        fs::copy(
            work.join("ratconfig-nova-v1.png"),
            public.join("ratconfig-nova-v1.png"),
        )?;
        files.push("ratconfig-nova-v1.png".into());
    }
    r.poster(&work.join(&files[0]), offset, &work.join(&files[1]))?;
    let readme = output.join("README.md");
    let mut hashes = fs::read_to_string(&readme)?;
    for file in &files {
        fs::copy(work.join(file), output.join(file))?;
        if variant == Variant::Sixty {
            fs::copy(work.join(file), public.join(file))?;
        }
        let digest = r.output(Command::new("sha256sum").arg(output.join(file)))?;
        let hash = digest
            .split_whitespace()
            .next()
            .ok_or_else(|| Error::Invalid("empty SHA-256 output".into()))?;
        let suffix = format!("  {file}");
        let line = format!("{hash}{suffix}");
        if hashes.lines().any(|line| line.ends_with(&suffix)) {
            hashes = hashes
                .lines()
                .map(|old| {
                    if old.ends_with(&suffix) {
                        line.as_str()
                    } else {
                        old
                    }
                })
                .collect::<Vec<_>>()
                .join("\n")
                + "\n";
        } else {
            hashes.push_str(&format!("{line}\n"));
        }
        println!("{line}");
    }
    fs::write(readme, hashes)?;
    r.exec(Command::new("ffprobe").args(["-v", "error", "-show_entries",
        "format=duration:stream=codec_name,width,height,pix_fmt,r_frame_rate,avg_frame_rate,nb_frames",
        "-of", "default=noprint_wrappers=1"]).arg(output.join(&files[0])))
}

fn main() -> ExitCode {
    let args: Vec<_> = env::args().skip(1).collect();
    if args.len() > 1 || args.first().is_some_and(|arg| arg == "--help") {
        println!(
            "Usage: nix run .#record-demo -- [original|session|sixty|popups|appearance|yazi|live|anima]"
        );
        return if args.len() > 1 {
            ExitCode::from(2)
        } else {
            ExitCode::SUCCESS
        };
    }
    kinestra::run(|r| {
        record(
            r,
            Variant::parse(args.first().map(String::as_str).unwrap_or("original"))?,
        )
    })
}
