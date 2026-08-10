.class public final synthetic Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar$$ExternalSyntheticLambda2;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Lcom/aliyun/emas/apm/components/ComponentFactory;


# direct methods
.method public synthetic constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final create(Lcom/aliyun/emas/apm/components/ComponentContainer;)Ljava/lang/Object;
    .locals 0

    invoke-static {p1}, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar;->$r8$lambda$8A9oBCqW_FfpxXmLCIHxWvtmbow(Lcom/aliyun/emas/apm/components/ComponentContainer;)Ljava/util/concurrent/ScheduledExecutorService;

    move-result-object p1

    return-object p1
.end method
