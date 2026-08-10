.class public final synthetic Lcom/aliyun/emas/apm/components/ComponentRuntime$$ExternalSyntheticLambda3;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/aliyun/emas/apm/components/c;

.field public final synthetic f$1:Lcom/aliyun/emas/apm/inject/Provider;


# direct methods
.method public synthetic constructor <init>(Lcom/aliyun/emas/apm/components/c;Lcom/aliyun/emas/apm/inject/Provider;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime$$ExternalSyntheticLambda3;->f$0:Lcom/aliyun/emas/apm/components/c;

    iput-object p2, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime$$ExternalSyntheticLambda3;->f$1:Lcom/aliyun/emas/apm/inject/Provider;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime$$ExternalSyntheticLambda3;->f$0:Lcom/aliyun/emas/apm/components/c;

    iget-object v1, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime$$ExternalSyntheticLambda3;->f$1:Lcom/aliyun/emas/apm/inject/Provider;

    invoke-static {v0, v1}, Lcom/aliyun/emas/apm/components/ComponentRuntime;->a(Lcom/aliyun/emas/apm/components/c;Lcom/aliyun/emas/apm/inject/Provider;)V

    return-void
.end method
