.class public Lcom/aliyun/emas/apm/crash/CustomKeysAndValues;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/crash/CustomKeysAndValues$Builder;
    }
.end annotation


# instance fields
.field final a:Ljava/util/Map;


# direct methods
.method constructor <init>(Lcom/aliyun/emas/apm/crash/CustomKeysAndValues$Builder;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    invoke-static {p1}, Lcom/aliyun/emas/apm/crash/CustomKeysAndValues$Builder;->a(Lcom/aliyun/emas/apm/crash/CustomKeysAndValues$Builder;)Ljava/util/Map;

    move-result-object p1

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/CustomKeysAndValues;->a:Ljava/util/Map;

    return-void
.end method
