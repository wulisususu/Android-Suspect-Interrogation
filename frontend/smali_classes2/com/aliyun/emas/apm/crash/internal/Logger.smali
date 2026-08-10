.class public Lcom/aliyun/emas/apm/crash/internal/Logger;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field static c:Z = false

.field static d:Lcom/aliyun/emas/apm/crash/internal/Logger;


# instance fields
.field private final a:Ljava/lang/String;

.field private b:I


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/Logger;->a:Ljava/lang/String;

    sget-boolean p1, Lcom/aliyun/emas/apm/crash/internal/Logger;->c:Z

    if-eqz p1, :cond_0

    const/4 p1, 0x2

    iput p1, p0, Lcom/aliyun/emas/apm/crash/internal/Logger;->b:I

    goto :goto_0

    :cond_0
    const/4 p1, 0x4

    iput p1, p0, Lcom/aliyun/emas/apm/crash/internal/Logger;->b:I

    :goto_0
    return-void
.end method

.method private a(I)Z
    .locals 1

    iget v0, p0, Lcom/aliyun/emas/apm/crash/internal/Logger;->b:I

    if-le v0, p1, :cond_1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/Logger;->a:Ljava/lang/String;

    .line 1
    invoke-static {v0, p1}, Landroid/util/Log;->isLoggable(Ljava/lang/String;I)Z

    move-result p1

    if-eqz p1, :cond_0

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 p1, 0x1

    :goto_1
    return p1
.end method

.method public static getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;
    .locals 2

    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/Logger;->d:Lcom/aliyun/emas/apm/crash/internal/Logger;

    if-nez v0, :cond_0

    .line 2
    new-instance v0, Lcom/aliyun/emas/apm/crash/internal/Logger;

    const-string v1, "Apm-CrashAnalysis"

    invoke-direct {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/Logger;-><init>(Ljava/lang/String;)V

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/Logger;->d:Lcom/aliyun/emas/apm/crash/internal/Logger;

    :cond_0
    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/Logger;->d:Lcom/aliyun/emas/apm/crash/internal/Logger;

    return-object v0
.end method

.method public static setOpenDebug(Z)V
    .locals 0

    sput-boolean p0, Lcom/aliyun/emas/apm/crash/internal/Logger;->c:Z

    return-void
.end method


# virtual methods
.method public d(Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    .line 3
    invoke-virtual {p0, p1, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->d(Ljava/lang/String;Ljava/lang/Throwable;)V

    return-void
.end method

.method public d(Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 1

    const/4 v0, 0x3

    .line 1
    invoke-direct {p0, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->a(I)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/Logger;->a:Ljava/lang/String;

    .line 2
    invoke-static {v0, p1, p2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_0
    return-void
.end method

.method public e(Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    .line 3
    invoke-virtual {p0, p1, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    return-void
.end method

.method public e(Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 1

    const/4 v0, 0x6

    .line 1
    invoke-direct {p0, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->a(I)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/Logger;->a:Ljava/lang/String;

    .line 2
    invoke-static {v0, p1, p2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_0
    return-void
.end method

.method public i(Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    .line 3
    invoke-virtual {p0, p1, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->i(Ljava/lang/String;Ljava/lang/Throwable;)V

    return-void
.end method

.method public i(Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 1

    const/4 v0, 0x4

    .line 1
    invoke-direct {p0, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->a(I)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/Logger;->a:Ljava/lang/String;

    .line 2
    invoke-static {v0, p1, p2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_0
    return-void
.end method

.method public log(ILjava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    .line 1
    invoke-virtual {p0, p1, p2, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->log(ILjava/lang/String;Z)V

    return-void
.end method

.method public log(ILjava/lang/String;Z)V
    .locals 0

    if-nez p3, :cond_0

    .line 2
    invoke-direct {p0, p1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->a(I)Z

    move-result p3

    if-eqz p3, :cond_1

    :cond_0
    iget-object p3, p0, Lcom/aliyun/emas/apm/crash/internal/Logger;->a:Ljava/lang/String;

    .line 3
    invoke-static {p1, p3, p2}, Landroid/util/Log;->println(ILjava/lang/String;Ljava/lang/String;)I

    :cond_1
    return-void
.end method

.method public v(Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    .line 3
    invoke-virtual {p0, p1, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->v(Ljava/lang/String;Ljava/lang/Throwable;)V

    return-void
.end method

.method public v(Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 1

    const/4 v0, 0x2

    .line 1
    invoke-direct {p0, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->a(I)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/Logger;->a:Ljava/lang/String;

    .line 2
    invoke-static {v0, p1, p2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_0
    return-void
.end method

.method public w(Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    .line 3
    invoke-virtual {p0, p1, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->w(Ljava/lang/String;Ljava/lang/Throwable;)V

    return-void
.end method

.method public w(Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 1

    const/4 v0, 0x5

    .line 1
    invoke-direct {p0, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->a(I)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/Logger;->a:Ljava/lang/String;

    .line 2
    invoke-static {v0, p1, p2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_0
    return-void
.end method
