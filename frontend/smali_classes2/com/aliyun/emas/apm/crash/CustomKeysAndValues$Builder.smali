.class public Lcom/aliyun/emas/apm/crash/CustomKeysAndValues$Builder;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/CustomKeysAndValues;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Builder"
.end annotation


# instance fields
.field private a:Ljava/util/Map;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 4
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/CustomKeysAndValues$Builder;->a:Ljava/util/Map;

    return-void
.end method

.method static synthetic a(Lcom/aliyun/emas/apm/crash/CustomKeysAndValues$Builder;)Ljava/util/Map;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/aliyun/emas/apm/crash/CustomKeysAndValues$Builder;->a:Ljava/util/Map;

    return-object p0
.end method


# virtual methods
.method public build()Lcom/aliyun/emas/apm/crash/CustomKeysAndValues;
    .locals 1

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/crash/CustomKeysAndValues;

    invoke-direct {v0, p0}, Lcom/aliyun/emas/apm/crash/CustomKeysAndValues;-><init>(Lcom/aliyun/emas/apm/crash/CustomKeysAndValues$Builder;)V

    return-object v0
.end method

.method public putBoolean(Ljava/lang/String;Z)Lcom/aliyun/emas/apm/crash/CustomKeysAndValues$Builder;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/CustomKeysAndValues$Builder;->a:Ljava/util/Map;

    .line 1
    invoke-static {p2}, Ljava/lang/Boolean;->toString(Z)Ljava/lang/String;

    move-result-object p2

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object p0
.end method

.method public putDouble(Ljava/lang/String;D)Lcom/aliyun/emas/apm/crash/CustomKeysAndValues$Builder;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/CustomKeysAndValues$Builder;->a:Ljava/util/Map;

    .line 1
    invoke-static {p2, p3}, Ljava/lang/Double;->toString(D)Ljava/lang/String;

    move-result-object p2

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object p0
.end method

.method public putFloat(Ljava/lang/String;F)Lcom/aliyun/emas/apm/crash/CustomKeysAndValues$Builder;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/CustomKeysAndValues$Builder;->a:Ljava/util/Map;

    .line 1
    invoke-static {p2}, Ljava/lang/Float;->toString(F)Ljava/lang/String;

    move-result-object p2

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object p0
.end method

.method public putInt(Ljava/lang/String;I)Lcom/aliyun/emas/apm/crash/CustomKeysAndValues$Builder;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/CustomKeysAndValues$Builder;->a:Ljava/util/Map;

    .line 1
    invoke-static {p2}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object p2

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object p0
.end method

.method public putLong(Ljava/lang/String;J)Lcom/aliyun/emas/apm/crash/CustomKeysAndValues$Builder;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/CustomKeysAndValues$Builder;->a:Ljava/util/Map;

    .line 1
    invoke-static {p2, p3}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object p2

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object p0
.end method

.method public putString(Ljava/lang/String;Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/CustomKeysAndValues$Builder;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/CustomKeysAndValues$Builder;->a:Ljava/util/Map;

    .line 1
    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object p0
.end method
