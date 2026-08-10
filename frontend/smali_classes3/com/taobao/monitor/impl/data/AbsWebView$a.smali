.class Lcom/taobao/monitor/impl/data/AbsWebView$a;
.super Ljava/lang/Object;
.source "AbsWebView.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/impl/data/AbsWebView;->isWebViewLoadFinished(Landroid/view/View;)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/view/View;

.field final synthetic a:Lcom/taobao/monitor/impl/data/AbsWebView;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/impl/data/AbsWebView;Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/data/AbsWebView$a;->a:Lcom/taobao/monitor/impl/data/AbsWebView;

    iput-object p2, p0, Lcom/taobao/monitor/impl/data/AbsWebView$a;->a:Landroid/view/View;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lcom/taobao/monitor/impl/data/AbsWebView$a;->a:Lcom/taobao/monitor/impl/data/AbsWebView;

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/AbsWebView$a;->a:Landroid/view/View;

    .line 1
    invoke-virtual {v0, v1}, Lcom/taobao/monitor/impl/data/AbsWebView;->getProgress(Landroid/view/View;)I

    move-result v1

    invoke-static {v0, v1}, Lcom/taobao/monitor/impl/data/AbsWebView;->access$002(Lcom/taobao/monitor/impl/data/AbsWebView;I)I

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/AbsWebView$a;->a:Lcom/taobao/monitor/impl/data/AbsWebView;

    .line 2
    invoke-static {v0}, Lcom/taobao/monitor/impl/data/AbsWebView;->access$000(Lcom/taobao/monitor/impl/data/AbsWebView;)I

    move-result v0

    const/16 v1, 0x64

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/AbsWebView$a;->a:Lcom/taobao/monitor/impl/data/AbsWebView;

    .line 3
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-static {v0, v1, v2}, Lcom/taobao/monitor/impl/data/AbsWebView;->access$102(Lcom/taobao/monitor/impl/data/AbsWebView;J)J
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    iget-object v0, p0, Lcom/taobao/monitor/impl/data/AbsWebView$a;->a:Lcom/taobao/monitor/impl/data/AbsWebView;

    const/4 v1, 0x0

    .line 6
    invoke-static {v0, v1}, Lcom/taobao/monitor/impl/data/AbsWebView;->access$002(Lcom/taobao/monitor/impl/data/AbsWebView;I)I

    :cond_0
    :goto_0
    return-void
.end method
