.class public Lcom/taobao/accs/messenger/e;
.super Ljava/lang/Object;
.source "Taobao"


# static fields
.field private static final a:Ljava/lang/String;


# instance fields
.field private final b:Ljava/util/concurrent/ScheduledExecutorService;

.field private final c:Lcom/taobao/accs/messenger/a;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 17
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-class v1, Lcom/taobao/accs/messenger/e;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ".TRY_COUNT"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/taobao/accs/messenger/e;->a:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Lcom/taobao/accs/messenger/a;)V
    .locals 1

    .line 21
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 18
    invoke-static {}, Ljava/util/concurrent/Executors;->newSingleThreadScheduledExecutor()Ljava/util/concurrent/ScheduledExecutorService;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/accs/messenger/e;->b:Ljava/util/concurrent/ScheduledExecutorService;

    iput-object p1, p0, Lcom/taobao/accs/messenger/e;->c:Lcom/taobao/accs/messenger/a;

    return-void
.end method

.method static synthetic a(Lcom/taobao/accs/messenger/e;Ljava/lang/String;Landroid/content/Intent;)V
    .locals 0

    .line 13
    invoke-direct {p0, p1, p2}, Lcom/taobao/accs/messenger/e;->b(Ljava/lang/String;Landroid/content/Intent;)V

    return-void
.end method

.method private b(Ljava/lang/String;Landroid/content/Intent;)V
    .locals 2

    iget-object v0, p0, Lcom/taobao/accs/messenger/e;->c:Lcom/taobao/accs/messenger/a;

    .line 36
    invoke-virtual {v0, p1}, Lcom/taobao/accs/messenger/a;->a(Ljava/lang/String;)Lcom/taobao/accs/messenger/d;

    move-result-object v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/accs/messenger/e;->c:Lcom/taobao/accs/messenger/a;

    .line 38
    invoke-virtual {v0, p1, p2}, Lcom/taobao/accs/messenger/a;->a(Ljava/lang/String;Landroid/content/Intent;)V

    .line 39
    invoke-direct {p0, p1, p2}, Lcom/taobao/accs/messenger/e;->c(Ljava/lang/String;Landroid/content/Intent;)V

    goto :goto_0

    .line 42
    :cond_0
    :try_start_0
    invoke-virtual {v0, p2}, Lcom/taobao/accs/messenger/d;->a(Landroid/content/Intent;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    iget-object v1, p0, Lcom/taobao/accs/messenger/e;->c:Lcom/taobao/accs/messenger/a;

    .line 45
    invoke-virtual {v1, p1, v0}, Lcom/taobao/accs/messenger/a;->b(Ljava/lang/String;Lcom/taobao/accs/messenger/d;)V

    iget-object v0, p0, Lcom/taobao/accs/messenger/e;->c:Lcom/taobao/accs/messenger/a;

    .line 46
    invoke-virtual {v0, p1, p2}, Lcom/taobao/accs/messenger/a;->a(Ljava/lang/String;Landroid/content/Intent;)V

    .line 47
    invoke-direct {p0, p1, p2}, Lcom/taobao/accs/messenger/e;->c(Ljava/lang/String;Landroid/content/Intent;)V

    :goto_0
    return-void
.end method

.method private c(Ljava/lang/String;Landroid/content/Intent;)V
    .locals 3

    sget-object v0, Lcom/taobao/accs/messenger/e;->a:Ljava/lang/String;

    const/4 v1, 0x0

    .line 53
    invoke-virtual {p2, v0, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v1

    const/16 v2, 0xa

    if-le v1, v2, :cond_0

    return-void

    :cond_0
    add-int/lit8 v1, v1, 0x1

    .line 59
    invoke-virtual {p2, v0, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    iget-object v0, p0, Lcom/taobao/accs/messenger/e;->b:Ljava/util/concurrent/ScheduledExecutorService;

    .line 60
    new-instance v1, Lcom/taobao/accs/messenger/f;

    invoke-direct {v1, p0, p1, p2}, Lcom/taobao/accs/messenger/f;-><init>(Lcom/taobao/accs/messenger/e;Ljava/lang/String;Landroid/content/Intent;)V

    const-wide/16 p1, 0x3e8

    sget-object v2, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-interface {v0, v1, p1, p2, v2}, Ljava/util/concurrent/ScheduledExecutorService;->schedule(Ljava/lang/Runnable;JLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/ScheduledFuture;

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;Landroid/content/Intent;)V
    .locals 0

    .line 32
    invoke-direct {p0, p1, p2}, Lcom/taobao/accs/messenger/e;->b(Ljava/lang/String;Landroid/content/Intent;)V

    return-void
.end method
