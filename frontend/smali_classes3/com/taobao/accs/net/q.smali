.class Lcom/taobao/accs/net/q;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Lcom/taobao/accs/net/j;


# direct methods
.method constructor <init>(Lcom/taobao/accs/net/j;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/accs/net/q;->a:Lcom/taobao/accs/net/j;

    .line 484
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lcom/taobao/accs/net/q;->a:Lcom/taobao/accs/net/j;

    .line 488
    iget-object v0, v0, Lcom/taobao/accs/net/j;->d:Landroid/content/Context;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/taobao/accs/net/q;->a:Lcom/taobao/accs/net/j;

    .line 491
    invoke-virtual {v0}, Lcom/taobao/accs/net/j;->i()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    return-void

    :cond_1
    iget-object v0, p0, Lcom/taobao/accs/net/q;->a:Lcom/taobao/accs/net/j;

    .line 494
    invoke-static {v0}, Lcom/taobao/accs/net/j;->a(Lcom/taobao/accs/net/j;)Lcom/alibaba/sdk/android/logger/ILog;

    move-result-object v0

    const-string v1, "mTryStartServiceRunnable bindApp"

    invoke-interface {v0, v1}, Lcom/alibaba/sdk/android/logger/ILog;->i(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/taobao/accs/net/q;->a:Lcom/taobao/accs/net/j;

    .line 495
    iget-object v1, v0, Lcom/taobao/accs/net/j;->d:Landroid/content/Context;

    invoke-virtual {v0, v1}, Lcom/taobao/accs/net/j;->b(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 497
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    :goto_0
    return-void
.end method
