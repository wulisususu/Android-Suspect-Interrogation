.class Lcom/taobao/accs/internal/a;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Landroid/content/Context;

.field final synthetic c:Lcom/taobao/accs/internal/ACCSManagerImpl;


# direct methods
.method constructor <init>(Lcom/taobao/accs/internal/ACCSManagerImpl;Ljava/lang/String;Landroid/content/Context;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/accs/internal/a;->c:Lcom/taobao/accs/internal/ACCSManagerImpl;

    iput-object p2, p0, Lcom/taobao/accs/internal/a;->a:Ljava/lang/String;

    iput-object p3, p0, Lcom/taobao/accs/internal/a;->b:Landroid/content/Context;

    .line 65
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lcom/taobao/accs/internal/a;->a:Ljava/lang/String;

    .line 69
    invoke-static {v0}, Lcom/taobao/accs/ACCSClient;->getAccsClient(Ljava/lang/String;)Lcom/taobao/accs/ACCSClient;

    move-result-object v0

    new-instance v1, Lcom/taobao/accs/internal/b;

    invoke-direct {v1, p0}, Lcom/taobao/accs/internal/b;-><init>(Lcom/taobao/accs/internal/a;)V

    invoke-virtual {v0, v1}, Lcom/taobao/accs/ACCSClient;->addConnectionListener(Lcom/taobao/accs/ConnectionListener;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    .line 87
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :goto_0
    return-void
.end method
