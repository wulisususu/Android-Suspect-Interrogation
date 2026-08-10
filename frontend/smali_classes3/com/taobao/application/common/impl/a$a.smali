.class Lcom/taobao/application/common/impl/a$a;
.super Ljava/lang/Object;
.source "ApmEventListenerGroup.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/application/common/impl/a;->onEvent(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:I

.field final synthetic a:Lcom/taobao/application/common/impl/a;


# direct methods
.method constructor <init>(Lcom/taobao/application/common/impl/a;I)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/application/common/impl/a$a;->a:Lcom/taobao/application/common/impl/a;

    iput p2, p0, Lcom/taobao/application/common/impl/a$a;->a:I

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lcom/taobao/application/common/impl/a$a;->a:Lcom/taobao/application/common/impl/a;

    .line 1
    invoke-static {v0}, Lcom/taobao/application/common/impl/a;->a(Lcom/taobao/application/common/impl/a;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/taobao/application/common/IApmEventListener;

    iget v2, p0, Lcom/taobao/application/common/impl/a$a;->a:I

    .line 2
    invoke-interface {v1, v2}, Lcom/taobao/application/common/IApmEventListener;->onEvent(I)V

    goto :goto_0

    :cond_0
    return-void
.end method
