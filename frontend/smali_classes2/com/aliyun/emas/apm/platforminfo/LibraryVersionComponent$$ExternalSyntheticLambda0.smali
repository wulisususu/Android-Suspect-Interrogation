.class public final synthetic Lcom/aliyun/emas/apm/platforminfo/LibraryVersionComponent$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Lcom/aliyun/emas/apm/components/ComponentFactory;


# instance fields
.field public final synthetic f$0:Ljava/lang/String;

.field public final synthetic f$1:Lcom/aliyun/emas/apm/platforminfo/LibraryVersionComponent$a;


# direct methods
.method public synthetic constructor <init>(Ljava/lang/String;Lcom/aliyun/emas/apm/platforminfo/LibraryVersionComponent$a;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/platforminfo/LibraryVersionComponent$$ExternalSyntheticLambda0;->f$0:Ljava/lang/String;

    iput-object p2, p0, Lcom/aliyun/emas/apm/platforminfo/LibraryVersionComponent$$ExternalSyntheticLambda0;->f$1:Lcom/aliyun/emas/apm/platforminfo/LibraryVersionComponent$a;

    return-void
.end method


# virtual methods
.method public final create(Lcom/aliyun/emas/apm/components/ComponentContainer;)Ljava/lang/Object;
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/platforminfo/LibraryVersionComponent$$ExternalSyntheticLambda0;->f$0:Ljava/lang/String;

    iget-object v1, p0, Lcom/aliyun/emas/apm/platforminfo/LibraryVersionComponent$$ExternalSyntheticLambda0;->f$1:Lcom/aliyun/emas/apm/platforminfo/LibraryVersionComponent$a;

    invoke-static {v0, v1, p1}, Lcom/aliyun/emas/apm/platforminfo/LibraryVersionComponent;->$r8$lambda$vDAF1pey9okdEl85-C0aYIrHFuM(Ljava/lang/String;Lcom/aliyun/emas/apm/platforminfo/LibraryVersionComponent$a;Lcom/aliyun/emas/apm/components/ComponentContainer;)Lcom/aliyun/emas/apm/platforminfo/LibraryVersion;

    move-result-object p1

    return-object p1
.end method
