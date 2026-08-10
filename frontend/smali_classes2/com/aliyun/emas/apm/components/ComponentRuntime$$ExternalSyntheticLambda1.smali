.class public final synthetic Lcom/aliyun/emas/apm/components/ComponentRuntime$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Lcom/aliyun/emas/apm/inject/Provider;


# instance fields
.field public final synthetic f$0:Lcom/aliyun/emas/apm/components/ComponentRuntime;

.field public final synthetic f$1:Lcom/aliyun/emas/apm/components/Component;


# direct methods
.method public synthetic constructor <init>(Lcom/aliyun/emas/apm/components/ComponentRuntime;Lcom/aliyun/emas/apm/components/Component;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime$$ExternalSyntheticLambda1;->f$0:Lcom/aliyun/emas/apm/components/ComponentRuntime;

    iput-object p2, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime$$ExternalSyntheticLambda1;->f$1:Lcom/aliyun/emas/apm/components/Component;

    return-void
.end method


# virtual methods
.method public final get()Ljava/lang/Object;
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime$$ExternalSyntheticLambda1;->f$0:Lcom/aliyun/emas/apm/components/ComponentRuntime;

    iget-object v1, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime$$ExternalSyntheticLambda1;->f$1:Lcom/aliyun/emas/apm/components/Component;

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/components/ComponentRuntime;->a(Lcom/aliyun/emas/apm/components/Component;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method
