.class Lcom/aliyun/emas/apm/crash/x$b;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/x;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "b"
.end annotation


# instance fields
.field private final a:Ljava/lang/String;

.field private final b:Ljava/lang/String;

.field final synthetic c:Lcom/aliyun/emas/apm/crash/x;


# direct methods
.method private constructor <init>(Lcom/aliyun/emas/apm/crash/x;)V
    .locals 1

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/x$b;->c:Lcom/aliyun/emas/apm/crash/x;

    .line 2
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "flutter_assets/NOTICES.Z"

    .line 4
    invoke-static {p1, v0}, Lcom/aliyun/emas/apm/crash/x;->a(Lcom/aliyun/emas/apm/crash/x;Ljava/lang/String;)Z

    move-result p1

    const/4 v0, 0x0

    if-eqz p1, :cond_0

    const-string p1, "Flutter"

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/x$b;->a:Ljava/lang/String;

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/x$b;->b:Ljava/lang/String;

    .line 8
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object p1

    const-string v0, "Development platform is: Flutter"

    invoke-virtual {p1, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->v(Ljava/lang/String;)V

    return-void

    :cond_0
    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/x$b;->a:Ljava/lang/String;

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/x$b;->b:Ljava/lang/String;

    return-void
.end method

.method synthetic constructor <init>(Lcom/aliyun/emas/apm/crash/x;Lcom/aliyun/emas/apm/crash/x$a;)V
    .locals 0

    .line 1
    invoke-direct {p0, p1}, Lcom/aliyun/emas/apm/crash/x$b;-><init>(Lcom/aliyun/emas/apm/crash/x;)V

    return-void
.end method

.method static synthetic a(Lcom/aliyun/emas/apm/crash/x$b;)Ljava/lang/String;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/aliyun/emas/apm/crash/x$b;->a:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic b(Lcom/aliyun/emas/apm/crash/x$b;)Ljava/lang/String;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/aliyun/emas/apm/crash/x$b;->b:Ljava/lang/String;

    return-object p0
.end method
