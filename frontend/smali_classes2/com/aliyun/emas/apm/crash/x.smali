.class public Lcom/aliyun/emas/apm/crash/x;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/crash/x$b;
    }
.end annotation


# instance fields
.field private final a:Landroid/content/Context;

.field private b:Lcom/aliyun/emas/apm/crash/x$b;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/x;->a:Landroid/content/Context;

    const/4 p1, 0x0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/x;->b:Lcom/aliyun/emas/apm/crash/x$b;

    return-void
.end method

.method static synthetic a(Lcom/aliyun/emas/apm/crash/x;Ljava/lang/String;)Z
    .locals 0

    .line 1
    invoke-direct {p0, p1}, Lcom/aliyun/emas/apm/crash/x;->a(Ljava/lang/String;)Z

    move-result p0

    return p0
.end method

.method private a(Ljava/lang/String;)Z
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/x;->a:Landroid/content/Context;

    .line 3
    invoke-virtual {v0}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/x;->a:Landroid/content/Context;

    .line 6
    invoke-virtual {v0}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object p1

    if-eqz p1, :cond_1

    .line 8
    invoke-virtual {p1}, Ljava/io/InputStream;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    :cond_1
    const/4 p1, 0x1

    return p1

    :catch_0
    return v1
.end method

.method private c()Lcom/aliyun/emas/apm/crash/x$b;
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/x;->b:Lcom/aliyun/emas/apm/crash/x$b;

    if-nez v0, :cond_0

    .line 2
    new-instance v0, Lcom/aliyun/emas/apm/crash/x$b;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/aliyun/emas/apm/crash/x$b;-><init>(Lcom/aliyun/emas/apm/crash/x;Lcom/aliyun/emas/apm/crash/x$a;)V

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/x;->b:Lcom/aliyun/emas/apm/crash/x$b;

    :cond_0
    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/x;->b:Lcom/aliyun/emas/apm/crash/x$b;

    return-object v0
.end method


# virtual methods
.method public a()Ljava/lang/String;
    .locals 1

    .line 2
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/x;->c()Lcom/aliyun/emas/apm/crash/x$b;

    move-result-object v0

    invoke-static {v0}, Lcom/aliyun/emas/apm/crash/x$b;->a(Lcom/aliyun/emas/apm/crash/x$b;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public b()Ljava/lang/String;
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/x;->c()Lcom/aliyun/emas/apm/crash/x$b;

    move-result-object v0

    invoke-static {v0}, Lcom/aliyun/emas/apm/crash/x$b;->b(Lcom/aliyun/emas/apm/crash/x$b;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
