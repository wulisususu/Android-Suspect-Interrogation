.class public final synthetic Lcom/aliyun/emas/apm/components/Component$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Lcom/aliyun/emas/apm/components/ComponentFactory;


# instance fields
.field public final synthetic f$0:Ljava/lang/Object;


# direct methods
.method public synthetic constructor <init>(Ljava/lang/Object;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/components/Component$$ExternalSyntheticLambda1;->f$0:Ljava/lang/Object;

    return-void
.end method


# virtual methods
.method public final create(Lcom/aliyun/emas/apm/components/ComponentContainer;)Ljava/lang/Object;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/Component$$ExternalSyntheticLambda1;->f$0:Ljava/lang/Object;

    invoke-static {v0, p1}, Lcom/aliyun/emas/apm/components/Component;->e(Ljava/lang/Object;Lcom/aliyun/emas/apm/components/ComponentContainer;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method
