.class public Lcom/ta/a/b/h;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# static fields
.field private static volatile a:Z = false


# instance fields
.field private mContext:Landroid/content/Context;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/ta/a/b/h;->mContext:Landroid/content/Context;

    return-void
.end method

.method private a()V
    .locals 1

    .line 33
    invoke-static {}, Lcom/ta/a/c/f;->e()V

    iget-object v0, p0, Lcom/ta/a/b/h;->mContext:Landroid/content/Context;

    .line 34
    invoke-static {v0}, Lcom/ta/a/c/d;->b(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    sget-boolean v0, Lcom/ta/a/b/h;->a:Z

    if-nez v0, :cond_1

    const/4 v0, 0x1

    sput-boolean v0, Lcom/ta/a/b/h;->a:Z

    const/4 v0, 0x0

    .line 43
    :try_start_0
    invoke-direct {p0}, Lcom/ta/a/b/h;->b()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :catchall_0
    sput-boolean v0, Lcom/ta/a/b/h;->a:Z

    :cond_1
    return-void
.end method

.method private a(Ljava/lang/String;)Z
    .locals 2

    const-string v0, "https://mpush-api.aliyun.com/v2.0/a/audid/req/"

    const/4 v1, 0x1

    .line 52
    invoke-static {v0, p1, v1}, Lcom/ta/a/b/b;->a(Ljava/lang/String;Ljava/lang/String;Z)Lcom/ta/a/b/a;

    move-result-object p1

    if-nez p1, :cond_0

    const/4 p1, 0x0

    return p1

    .line 57
    :cond_0
    invoke-static {p1}, Lcom/ta/utdid2/device/e;->a(Lcom/ta/a/b/a;)Z

    move-result p1

    return p1
.end method

.method private b()V
    .locals 2

    .line 61
    invoke-static {}, Lcom/ta/a/c/f;->e()V

    .line 63
    invoke-direct {p0}, Lcom/ta/a/b/h;->e()Ljava/lang/String;

    move-result-object v0

    .line 64
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    const-string v1, "postData is empty"

    .line 65
    invoke-static {v1, v0}, Lcom/ta/a/c/f;->a(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void

    .line 69
    :cond_0
    invoke-direct {p0, v0}, Lcom/ta/a/b/h;->a(Ljava/lang/String;)Z

    move-result v0

    const-string v1, ""

    if-eqz v0, :cond_1

    const-string v0, "upload success"

    .line 71
    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/ta/a/c/f;->a(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_0

    :cond_1
    const-string v0, "upload fail"

    .line 73
    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/ta/a/c/f;->a(Ljava/lang/String;[Ljava/lang/Object;)V

    :goto_0
    return-void
.end method

.method private e()Ljava/lang/String;
    .locals 3

    .line 78
    invoke-static {}, Lcom/ta/utdid2/device/a;->a()Lcom/ta/utdid2/device/a;

    move-result-object v0

    invoke-virtual {v0}, Lcom/ta/utdid2/device/a;->m()Ljava/lang/String;

    move-result-object v0

    .line 79
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 83
    :cond_0
    invoke-static {v0}, Lcom/ta/a/a/a;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 85
    invoke-static {}, Lcom/ta/a/c/f;->a()Z

    move-result v1

    if-eqz v1, :cond_1

    const-string v1, ""

    .line 86
    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/ta/a/c/f;->b(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 88
    :cond_1
    invoke-static {v0}, Lcom/ta/a/a/b;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 26
    :try_start_0
    invoke-direct {p0}, Lcom/ta/a/b/h;->a()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    const-string v2, ""

    .line 28
    invoke-static {v2, v0, v1}, Lcom/ta/a/c/f;->a(Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :goto_0
    return-void
.end method
