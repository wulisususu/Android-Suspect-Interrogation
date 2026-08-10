.class Lcom/taobao/application/common/impl/h$c;
.super Ljava/lang/Object;
.source "PageFpsListenerGroup.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/application/common/impl/h;->onPageFpsReceived(Ljava/lang/String;Ljava/lang/Object;IF)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:F

.field final synthetic a:I

.field final synthetic a:Lcom/taobao/application/common/impl/h;

.field final synthetic a:Ljava/lang/Object;

.field final synthetic a:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/taobao/application/common/impl/h;Ljava/lang/String;Ljava/lang/Object;IF)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/application/common/impl/h$c;->a:Lcom/taobao/application/common/impl/h;

    iput-object p2, p0, Lcom/taobao/application/common/impl/h$c;->a:Ljava/lang/String;

    iput-object p3, p0, Lcom/taobao/application/common/impl/h$c;->a:Ljava/lang/Object;

    iput p4, p0, Lcom/taobao/application/common/impl/h$c;->a:I

    iput p5, p0, Lcom/taobao/application/common/impl/h$c;->a:F

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    iget-object v0, p0, Lcom/taobao/application/common/impl/h$c;->a:Lcom/taobao/application/common/impl/h;

    .line 1
    invoke-static {v0}, Lcom/taobao/application/common/impl/h;->a(Lcom/taobao/application/common/impl/h;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/taobao/application/common/IPageFpsListener;

    iget-object v2, p0, Lcom/taobao/application/common/impl/h$c;->a:Ljava/lang/String;

    iget-object v3, p0, Lcom/taobao/application/common/impl/h$c;->a:Ljava/lang/Object;

    iget v4, p0, Lcom/taobao/application/common/impl/h$c;->a:I

    iget v5, p0, Lcom/taobao/application/common/impl/h$c;->a:F

    .line 2
    invoke-interface {v1, v2, v3, v4, v5}, Lcom/taobao/application/common/IPageFpsListener;->onPageFpsReceived(Ljava/lang/String;Ljava/lang/Object;IF)V

    goto :goto_0

    :cond_0
    return-void
.end method
