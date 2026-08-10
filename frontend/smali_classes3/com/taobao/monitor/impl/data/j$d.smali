.class Lcom/taobao/monitor/impl/data/j$d;
.super Ljava/lang/Object;
.source "SimplePageLoadCalculate.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/impl/data/j;->d()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/taobao/monitor/impl/data/j;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/impl/data/j;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/data/j$d;->a:Lcom/taobao/monitor/impl/data/j;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/j$d;->a:Lcom/taobao/monitor/impl/data/j;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/data/j;->a(Lcom/taobao/monitor/impl/data/j;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getViewTreeObserver()Landroid/view/ViewTreeObserver;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/j$d;->a:Lcom/taobao/monitor/impl/data/j;

    .line 3
    invoke-virtual {v0, v1}, Landroid/view/ViewTreeObserver;->removeOnDrawListener(Landroid/view/ViewTreeObserver$OnDrawListener;)V

    :cond_0
    return-void
.end method
