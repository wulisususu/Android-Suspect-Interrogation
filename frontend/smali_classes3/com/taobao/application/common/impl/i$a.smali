.class Lcom/taobao/application/common/impl/i$a;
.super Ljava/lang/Object;
.source "PageListenerGroup.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/application/common/impl/i;->onPageChanged(Ljava/lang/String;IJ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:I

.field final synthetic a:J

.field final synthetic a:Lcom/taobao/application/common/impl/i;

.field final synthetic a:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/taobao/application/common/impl/i;Ljava/lang/String;IJ)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/application/common/impl/i$a;->a:Lcom/taobao/application/common/impl/i;

    iput-object p2, p0, Lcom/taobao/application/common/impl/i$a;->a:Ljava/lang/String;

    iput p3, p0, Lcom/taobao/application/common/impl/i$a;->a:I

    iput-wide p4, p0, Lcom/taobao/application/common/impl/i$a;->a:J

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    iget-object v0, p0, Lcom/taobao/application/common/impl/i$a;->a:Lcom/taobao/application/common/impl/i;

    .line 1
    invoke-static {v0}, Lcom/taobao/application/common/impl/i;->a(Lcom/taobao/application/common/impl/i;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/taobao/application/common/IPageListener;

    iget-object v2, p0, Lcom/taobao/application/common/impl/i$a;->a:Ljava/lang/String;

    iget v3, p0, Lcom/taobao/application/common/impl/i$a;->a:I

    iget-wide v4, p0, Lcom/taobao/application/common/impl/i$a;->a:J

    .line 2
    invoke-interface {v1, v2, v3, v4, v5}, Lcom/taobao/application/common/IPageListener;->onPageChanged(Ljava/lang/String;IJ)V

    goto :goto_0

    :cond_0
    return-void
.end method
