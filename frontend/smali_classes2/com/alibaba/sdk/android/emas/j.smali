.class public Lcom/alibaba/sdk/android/emas/j;
.super Ljava/lang/Object;
.source "SendManager.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/alibaba/sdk/android/emas/j$a;,
        Lcom/alibaba/sdk/android/emas/j$b;
    }
.end annotation


# static fields
.field private static final a:Ljava/util/concurrent/ThreadPoolExecutor;


# instance fields
.field private a:Lcom/alibaba/sdk/android/emas/PreSendHandler;

.field private a:Ljava/util/concurrent/ExecutorService;

.field private final b:Lcom/alibaba/sdk/android/emas/EmasSender;

.field private d:Z

.field private f:I

.field private final mDiskCacheManager:Lcom/alibaba/sdk/android/emas/e;

.field private final mSendService:Lcom/alibaba/sdk/android/tbrest/SendService;


# direct methods
.method static constructor <clinit>()V
    .locals 9

    .line 38
    new-instance v8, Ljava/util/concurrent/ThreadPoolExecutor;

    const/4 v1, 0x3

    const/4 v2, 0x3

    const-wide/16 v3, 0xa

    sget-object v5, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    new-instance v6, Ljava/util/concurrent/LinkedBlockingQueue;

    const/16 v0, 0xa

    invoke-direct {v6, v0}, Ljava/util/concurrent/LinkedBlockingQueue;-><init>(I)V

    new-instance v7, Lcom/alibaba/sdk/android/emas/j$a;

    const/4 v0, 0x0

    invoke-direct {v7, v0}, Lcom/alibaba/sdk/android/emas/j$a;-><init>(Lcom/alibaba/sdk/android/emas/j$1;)V

    move-object v0, v8

    invoke-direct/range {v0 .. v7}, Ljava/util/concurrent/ThreadPoolExecutor;-><init>(IIJLjava/util/concurrent/TimeUnit;Ljava/util/concurrent/BlockingQueue;Ljava/util/concurrent/RejectedExecutionHandler;)V

    sput-object v8, Lcom/alibaba/sdk/android/emas/j;->a:Ljava/util/concurrent/ThreadPoolExecutor;

    return-void
.end method

.method public constructor <init>(Lcom/alibaba/sdk/android/emas/EmasSender;Lcom/alibaba/sdk/android/emas/e;)V
    .locals 1

    .line 41
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/alibaba/sdk/android/emas/j;->d:Z

    iput v0, p0, Lcom/alibaba/sdk/android/emas/j;->f:I

    iput-object p1, p0, Lcom/alibaba/sdk/android/emas/j;->b:Lcom/alibaba/sdk/android/emas/EmasSender;

    .line 43
    new-instance p1, Lcom/alibaba/sdk/android/tbrest/SendService;

    invoke-direct {p1}, Lcom/alibaba/sdk/android/tbrest/SendService;-><init>()V

    iput-object p1, p0, Lcom/alibaba/sdk/android/emas/j;->mSendService:Lcom/alibaba/sdk/android/tbrest/SendService;

    iput-object p2, p0, Lcom/alibaba/sdk/android/emas/j;->mDiskCacheManager:Lcom/alibaba/sdk/android/emas/e;

    const/4 p1, 0x5

    .line 46
    invoke-static {p1}, Ljava/util/concurrent/Executors;->newFixedThreadPool(I)Ljava/util/concurrent/ExecutorService;

    move-result-object p1

    iput-object p1, p0, Lcom/alibaba/sdk/android/emas/j;->a:Ljava/util/concurrent/ExecutorService;

    return-void
.end method

.method static synthetic a(Lcom/alibaba/sdk/android/emas/j;)I
    .locals 0

    .line 24
    iget p0, p0, Lcom/alibaba/sdk/android/emas/j;->f:I

    return p0
.end method

.method static synthetic a(Lcom/alibaba/sdk/android/emas/j;)Lcom/alibaba/sdk/android/emas/EmasSender;
    .locals 0

    .line 24
    iget-object p0, p0, Lcom/alibaba/sdk/android/emas/j;->b:Lcom/alibaba/sdk/android/emas/EmasSender;

    return-object p0
.end method

.method static synthetic a(Lcom/alibaba/sdk/android/emas/j;)Lcom/alibaba/sdk/android/emas/PreSendHandler;
    .locals 0

    .line 24
    iget-object p0, p0, Lcom/alibaba/sdk/android/emas/j;->a:Lcom/alibaba/sdk/android/emas/PreSendHandler;

    return-object p0
.end method

.method static synthetic a(Lcom/alibaba/sdk/android/emas/j;)Lcom/alibaba/sdk/android/emas/e;
    .locals 0

    .line 24
    iget-object p0, p0, Lcom/alibaba/sdk/android/emas/j;->mDiskCacheManager:Lcom/alibaba/sdk/android/emas/e;

    return-object p0
.end method

.method static synthetic a(Lcom/alibaba/sdk/android/emas/j;)Lcom/alibaba/sdk/android/tbrest/SendService;
    .locals 0

    .line 24
    iget-object p0, p0, Lcom/alibaba/sdk/android/emas/j;->mSendService:Lcom/alibaba/sdk/android/tbrest/SendService;

    return-object p0
.end method

.method static synthetic a(Lcom/alibaba/sdk/android/emas/j;)Ljava/util/concurrent/ExecutorService;
    .locals 0

    .line 24
    iget-object p0, p0, Lcom/alibaba/sdk/android/emas/j;->a:Ljava/util/concurrent/ExecutorService;

    return-object p0
.end method

.method static synthetic a()Ljava/util/concurrent/ThreadPoolExecutor;
    .locals 1

    sget-object v0, Lcom/alibaba/sdk/android/emas/j;->a:Ljava/util/concurrent/ThreadPoolExecutor;

    return-object v0
.end method

.method static synthetic a(Lcom/alibaba/sdk/android/emas/j;Lcom/alibaba/sdk/android/emas/f;)V
    .locals 0

    .line 24
    invoke-direct {p0, p1}, Lcom/alibaba/sdk/android/emas/j;->c(Lcom/alibaba/sdk/android/emas/f;)V

    return-void
.end method

.method private c(Lcom/alibaba/sdk/android/emas/f;)V
    .locals 4

    sget-object v0, Lcom/alibaba/sdk/android/emas/j;->a:Ljava/util/concurrent/ThreadPoolExecutor;

    .line 105
    new-instance v1, Lcom/alibaba/sdk/android/emas/j$b;

    iget-boolean v2, p0, Lcom/alibaba/sdk/android/emas/j;->d:Z

    iget v3, p0, Lcom/alibaba/sdk/android/emas/j;->f:I

    invoke-direct {v1, p0, p1, v2, v3}, Lcom/alibaba/sdk/android/emas/j$b;-><init>(Lcom/alibaba/sdk/android/emas/j;Lcom/alibaba/sdk/android/emas/f;ZI)V

    invoke-virtual {v0, v1}, Ljava/util/concurrent/ThreadPoolExecutor;->execute(Ljava/lang/Runnable;)V

    return-void
.end method


# virtual methods
.method public a()Lcom/alibaba/sdk/android/tbrest/SendService;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/j;->mSendService:Lcom/alibaba/sdk/android/tbrest/SendService;

    return-object v0
.end method

.method public a(I)V
    .locals 1

    const/16 v0, 0xa

    if-lt p1, v0, :cond_0

    const/16 p1, 0x9

    iput p1, p0, Lcom/alibaba/sdk/android/emas/j;->f:I

    goto :goto_0

    :cond_0
    iput p1, p0, Lcom/alibaba/sdk/android/emas/j;->f:I

    :goto_0
    return-void
.end method

.method public a(Lcom/alibaba/sdk/android/emas/PreSendHandler;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/emas/j;->a:Lcom/alibaba/sdk/android/emas/PreSendHandler;

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/j;->mSendService:Lcom/alibaba/sdk/android/tbrest/SendService;

    .line 58
    iput-object p1, v0, Lcom/alibaba/sdk/android/tbrest/SendService;->appSecret:Ljava/lang/String;

    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/alibaba/sdk/android/emas/g;",
            ">;)V"
        }
    .end annotation

    .line 101
    new-instance v0, Lcom/alibaba/sdk/android/emas/f;

    invoke-direct {v0, p1}, Lcom/alibaba/sdk/android/emas/f;-><init>(Ljava/util/List;)V

    invoke-direct {p0, v0}, Lcom/alibaba/sdk/android/emas/j;->c(Lcom/alibaba/sdk/android/emas/f;)V

    return-void
.end method

.method public a(Z)V
    .locals 0

    iput-boolean p1, p0, Lcom/alibaba/sdk/android/emas/j;->d:Z

    return-void
.end method

.method public b(Lcom/alibaba/sdk/android/emas/g;)V
    .locals 1

    .line 94
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 95
    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 97
    invoke-virtual {p0, v0}, Lcom/alibaba/sdk/android/emas/j;->a(Ljava/util/List;)V

    return-void
.end method

.method e()V
    .locals 2

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/j;->mDiskCacheManager:Lcom/alibaba/sdk/android/emas/e;

    if-nez v0, :cond_0

    return-void

    :cond_0
    sget-object v0, Lcom/alibaba/sdk/android/emas/j;->a:Ljava/util/concurrent/ThreadPoolExecutor;

    .line 113
    invoke-virtual {v0}, Ljava/util/concurrent/ThreadPoolExecutor;->getQueue()Ljava/util/concurrent/BlockingQueue;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/concurrent/BlockingQueue;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 114
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/alibaba/sdk/android/emas/j$1;

    invoke-direct {v1, p0}, Lcom/alibaba/sdk/android/emas/j$1;-><init>(Lcom/alibaba/sdk/android/emas/j;)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 127
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    :cond_1
    return-void
.end method

.method public getNoCollectionDataType()I
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/j;->mSendService:Lcom/alibaba/sdk/android/tbrest/SendService;

    .line 78
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/tbrest/SendService;->getNoCollectionDataType()I

    move-result v0

    return v0
.end method

.method public init(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 7

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/j;->mSendService:Lcom/alibaba/sdk/android/tbrest/SendService;

    .line 50
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object v5, p5

    move-object v6, p6

    invoke-virtual/range {v0 .. v6}, Lcom/alibaba/sdk/android/tbrest/SendService;->init(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public openHttp(Z)V
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/j;->mSendService:Lcom/alibaba/sdk/android/tbrest/SendService;

    .line 62
    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    iput-object p1, v0, Lcom/alibaba/sdk/android/tbrest/SendService;->openHttp:Ljava/lang/Boolean;

    return-void
.end method

.method public setHost(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/j;->mSendService:Lcom/alibaba/sdk/android/tbrest/SendService;

    .line 54
    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/tbrest/SendService;->changeHost(Ljava/lang/String;)V

    return-void
.end method

.method public setNoCollectionDataType(I)V
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/j;->mSendService:Lcom/alibaba/sdk/android/tbrest/SendService;

    .line 74
    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/tbrest/SendService;->setNoCollectionDataType(I)V

    return-void
.end method

.method public setUserNick(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/j;->mSendService:Lcom/alibaba/sdk/android/tbrest/SendService;

    .line 70
    iput-object p1, v0, Lcom/alibaba/sdk/android/tbrest/SendService;->userNick:Ljava/lang/String;

    return-void
.end method
