.class public Lcom/aliyun/emas/apm/crash/e0;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/crash/e0$b;
    }
.end annotation


# static fields
.field private static final c:Lcom/aliyun/emas/apm/crash/e0$b;


# instance fields
.field private final a:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

.field private b:Lcom/aliyun/emas/apm/crash/a0;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/crash/e0$b;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/aliyun/emas/apm/crash/e0$b;-><init>(Lcom/aliyun/emas/apm/crash/e0$a;)V

    sput-object v0, Lcom/aliyun/emas/apm/crash/e0;->c:Lcom/aliyun/emas/apm/crash/e0$b;

    return-void
.end method

.method public constructor <init>(Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/e0;->a:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    sget-object p1, Lcom/aliyun/emas/apm/crash/e0;->c:Lcom/aliyun/emas/apm/crash/e0$b;

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/e0;->b:Lcom/aliyun/emas/apm/crash/a0;

    return-void
.end method

.method public constructor <init>(Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;Ljava/lang/String;)V
    .locals 0

    .line 4
    invoke-direct {p0, p1}, Lcom/aliyun/emas/apm/crash/e0;-><init>(Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;)V

    .line 5
    invoke-virtual {p0, p2}, Lcom/aliyun/emas/apm/crash/e0;->b(Ljava/lang/String;)V

    return-void
.end method

.method private a(Ljava/lang/String;)Ljava/io/File;
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/e0;->a:Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;

    const-string v1, "userlog"

    .line 4
    invoke-virtual {v0, p1, v1}, Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;->getSessionFile(Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    return-object p1
.end method


# virtual methods
.method public a()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/e0;->b:Lcom/aliyun/emas/apm/crash/a0;

    .line 2
    invoke-interface {v0}, Lcom/aliyun/emas/apm/crash/a0;->a()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public a(JLjava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/e0;->b:Lcom/aliyun/emas/apm/crash/a0;

    .line 1
    invoke-interface {v0, p1, p2, p3}, Lcom/aliyun/emas/apm/crash/a0;->a(JLjava/lang/String;)V

    return-void
.end method

.method a(Ljava/io/File;I)V
    .locals 1

    .line 3
    new-instance v0, Lcom/aliyun/emas/apm/crash/p0;

    invoke-direct {v0, p1, p2}, Lcom/aliyun/emas/apm/crash/p0;-><init>(Ljava/io/File;I)V

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/e0;->b:Lcom/aliyun/emas/apm/crash/a0;

    return-void
.end method

.method public final b(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/e0;->b:Lcom/aliyun/emas/apm/crash/a0;

    .line 1
    invoke-interface {v0}, Lcom/aliyun/emas/apm/crash/a0;->b()V

    sget-object v0, Lcom/aliyun/emas/apm/crash/e0;->c:Lcom/aliyun/emas/apm/crash/e0$b;

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/e0;->b:Lcom/aliyun/emas/apm/crash/a0;

    if-nez p1, :cond_0

    return-void

    .line 8
    :cond_0
    invoke-direct {p0, p1}, Lcom/aliyun/emas/apm/crash/e0;->a(Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    const/high16 v0, 0x10000

    invoke-virtual {p0, p1, v0}, Lcom/aliyun/emas/apm/crash/e0;->a(Ljava/io/File;I)V

    return-void
.end method
