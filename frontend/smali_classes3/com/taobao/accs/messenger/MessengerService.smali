.class public abstract Lcom/taobao/accs/messenger/MessengerService;
.super Landroid/app/Service;
.source "Taobao"


# static fields
.field public static final INTENT:Ljava/lang/String; = "intent"


# instance fields
.field private a:Ljava/util/concurrent/ExecutorService;

.field private b:Landroid/os/Messenger;


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 19
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    .line 22
    invoke-static {}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/accs/messenger/MessengerService;->a:Ljava/util/concurrent/ExecutorService;

    .line 24
    new-instance v0, Landroid/os/Messenger;

    new-instance v1, Lcom/taobao/accs/messenger/b;

    invoke-direct {v1, p0}, Lcom/taobao/accs/messenger/b;-><init>(Lcom/taobao/accs/messenger/MessengerService;)V

    invoke-direct {v0, v1}, Landroid/os/Messenger;-><init>(Landroid/os/Handler;)V

    iput-object v0, p0, Lcom/taobao/accs/messenger/MessengerService;->b:Landroid/os/Messenger;

    return-void
.end method

.method static synthetic a(Lcom/taobao/accs/messenger/MessengerService;)Ljava/util/concurrent/ExecutorService;
    .locals 0

    .line 19
    iget-object p0, p0, Lcom/taobao/accs/messenger/MessengerService;->a:Ljava/util/concurrent/ExecutorService;

    return-object p0
.end method

.method static synthetic a()V
    .locals 0

    return-void
.end method
