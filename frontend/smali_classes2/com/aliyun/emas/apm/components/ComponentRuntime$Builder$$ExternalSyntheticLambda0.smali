.class public final synthetic Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Lcom/aliyun/emas/apm/inject/Provider;


# instance fields
.field public final synthetic f$0:Lcom/aliyun/emas/apm/components/ComponentRegistrar;


# direct methods
.method public synthetic constructor <init>(Lcom/aliyun/emas/apm/components/ComponentRegistrar;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder$$ExternalSyntheticLambda0;->f$0:Lcom/aliyun/emas/apm/components/ComponentRegistrar;

    return-void
.end method


# virtual methods
.method public final get()Ljava/lang/Object;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder$$ExternalSyntheticLambda0;->f$0:Lcom/aliyun/emas/apm/components/ComponentRegistrar;

    invoke-static {v0}, Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;->a(Lcom/aliyun/emas/apm/components/ComponentRegistrar;)Lcom/aliyun/emas/apm/components/ComponentRegistrar;

    move-result-object v0

    return-object v0
.end method
