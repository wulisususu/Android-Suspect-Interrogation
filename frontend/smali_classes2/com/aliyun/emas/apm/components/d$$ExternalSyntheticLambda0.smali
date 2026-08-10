.class public final synthetic Lcom/aliyun/emas/apm/components/d$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;


# instance fields
.field public final synthetic f$0:Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;

.field public final synthetic f$1:Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;


# direct methods
.method public synthetic constructor <init>(Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/components/d$$ExternalSyntheticLambda0;->f$0:Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;

    iput-object p2, p0, Lcom/aliyun/emas/apm/components/d$$ExternalSyntheticLambda0;->f$1:Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;

    return-void
.end method


# virtual methods
.method public final handle(Lcom/aliyun/emas/apm/inject/Provider;)V
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/d$$ExternalSyntheticLambda0;->f$0:Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;

    iget-object v1, p0, Lcom/aliyun/emas/apm/components/d$$ExternalSyntheticLambda0;->f$1:Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;

    invoke-static {v0, v1, p1}, Lcom/aliyun/emas/apm/components/d;->a(Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;Lcom/aliyun/emas/apm/inject/Provider;)V

    return-void
.end method
