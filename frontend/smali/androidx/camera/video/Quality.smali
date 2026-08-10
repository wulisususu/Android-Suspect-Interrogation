.class public Landroidx/camera/video/Quality;
.super Ljava/lang/Object;
.source "Quality.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/camera/video/Quality$ConstantQuality;
    }
.end annotation


# static fields
.field public static final FHD:Landroidx/camera/video/Quality;

.field public static final HD:Landroidx/camera/video/Quality;

.field public static final HIGHEST:Landroidx/camera/video/Quality;

.field public static final LOWEST:Landroidx/camera/video/Quality;

.field static final NONE:Landroidx/camera/video/Quality;

.field private static final QUALITIES:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Landroidx/camera/video/Quality;",
            ">;"
        }
    .end annotation
.end field

.field private static final QUALITIES_ORDER_BY_SIZE:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Landroidx/camera/video/Quality;",
            ">;"
        }
    .end annotation
.end field

.field public static final SD:Landroidx/camera/video/Quality;

.field public static final UHD:Landroidx/camera/video/Quality;


# direct methods
.method static constructor <clinit>()V
    .locals 15

    const/4 v0, 0x2

    new-array v1, v0, [Landroid/util/Size;

    .line 54
    new-instance v2, Landroid/util/Size;

    const/16 v3, 0x2d0

    const/16 v4, 0x1e0

    invoke-direct {v2, v3, v4}, Landroid/util/Size;-><init>(II)V

    const/4 v5, 0x0

    aput-object v2, v1, v5

    new-instance v2, Landroid/util/Size;

    const/16 v6, 0x280

    invoke-direct {v2, v6, v4}, Landroid/util/Size;-><init>(II)V

    const/4 v4, 0x1

    aput-object v2, v1, v4

    .line 55
    invoke-static {v1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    invoke-static {v1}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v1

    const/4 v2, 0x4

    const-string v6, "SD"

    .line 54
    invoke-static {v2, v6, v1}, Landroidx/camera/video/Quality$ConstantQuality;->of(ILjava/lang/String;Ljava/util/List;)Landroidx/camera/video/Quality$ConstantQuality;

    move-result-object v1

    sput-object v1, Landroidx/camera/video/Quality;->SD:Landroidx/camera/video/Quality;

    .line 62
    new-instance v6, Landroid/util/Size;

    const/16 v7, 0x500

    invoke-direct {v6, v7, v3}, Landroid/util/Size;-><init>(II)V

    .line 63
    invoke-static {v6}, Ljava/util/Collections;->singletonList(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v3

    const/4 v6, 0x5

    const-string v7, "HD"

    .line 62
    invoke-static {v6, v7, v3}, Landroidx/camera/video/Quality$ConstantQuality;->of(ILjava/lang/String;Ljava/util/List;)Landroidx/camera/video/Quality$ConstantQuality;

    move-result-object v3

    sput-object v3, Landroidx/camera/video/Quality;->HD:Landroidx/camera/video/Quality;

    .line 70
    new-instance v7, Landroid/util/Size;

    const/16 v8, 0x780

    const/16 v9, 0x438

    invoke-direct {v7, v8, v9}, Landroid/util/Size;-><init>(II)V

    .line 71
    invoke-static {v7}, Ljava/util/Collections;->singletonList(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v7

    const/4 v8, 0x6

    const-string v9, "FHD"

    .line 70
    invoke-static {v8, v9, v7}, Landroidx/camera/video/Quality$ConstantQuality;->of(ILjava/lang/String;Ljava/util/List;)Landroidx/camera/video/Quality$ConstantQuality;

    move-result-object v7

    sput-object v7, Landroidx/camera/video/Quality;->FHD:Landroidx/camera/video/Quality;

    .line 78
    new-instance v9, Landroid/util/Size;

    const/16 v10, 0xf00

    const/16 v11, 0x870

    invoke-direct {v9, v10, v11}, Landroid/util/Size;-><init>(II)V

    .line 79
    invoke-static {v9}, Ljava/util/Collections;->singletonList(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v9

    const/16 v10, 0x8

    const-string v11, "UHD"

    .line 78
    invoke-static {v10, v11, v9}, Landroidx/camera/video/Quality$ConstantQuality;->of(ILjava/lang/String;Ljava/util/List;)Landroidx/camera/video/Quality$ConstantQuality;

    move-result-object v9

    sput-object v9, Landroidx/camera/video/Quality;->UHD:Landroidx/camera/video/Quality;

    const-string v10, "LOWEST"

    .line 85
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v11

    .line 84
    invoke-static {v5, v10, v11}, Landroidx/camera/video/Quality$ConstantQuality;->of(ILjava/lang/String;Ljava/util/List;)Landroidx/camera/video/Quality$ConstantQuality;

    move-result-object v10

    sput-object v10, Landroidx/camera/video/Quality;->LOWEST:Landroidx/camera/video/Quality;

    const-string v11, "HIGHEST"

    .line 91
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v12

    .line 90
    invoke-static {v4, v11, v12}, Landroidx/camera/video/Quality$ConstantQuality;->of(ILjava/lang/String;Ljava/util/List;)Landroidx/camera/video/Quality$ConstantQuality;

    move-result-object v11

    sput-object v11, Landroidx/camera/video/Quality;->HIGHEST:Landroidx/camera/video/Quality;

    const-string v12, "NONE"

    .line 93
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v13

    const/4 v14, -0x1

    invoke-static {v14, v12, v13}, Landroidx/camera/video/Quality$ConstantQuality;->of(ILjava/lang/String;Ljava/util/List;)Landroidx/camera/video/Quality$ConstantQuality;

    move-result-object v12

    sput-object v12, Landroidx/camera/video/Quality;->NONE:Landroidx/camera/video/Quality;

    .line 96
    new-instance v12, Ljava/util/HashSet;

    new-array v8, v8, [Landroidx/camera/video/Quality;

    aput-object v10, v8, v5

    aput-object v11, v8, v4

    aput-object v1, v8, v0

    const/4 v10, 0x3

    aput-object v3, v8, v10

    aput-object v7, v8, v2

    aput-object v9, v8, v6

    .line 97
    invoke-static {v8}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v6

    invoke-direct {v12, v6}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    sput-object v12, Landroidx/camera/video/Quality;->QUALITIES:Ljava/util/Set;

    new-array v2, v2, [Landroidx/camera/video/Quality;

    .line 100
    aput-object v9, v2, v5

    aput-object v7, v2, v4

    aput-object v3, v2, v0

    aput-object v1, v2, v10

    invoke-static {v2}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    sput-object v0, Landroidx/camera/video/Quality;->QUALITIES_ORDER_BY_SIZE:Ljava/util/List;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 45
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Landroidx/camera/video/Quality$1;)V
    .locals 0

    .line 42
    invoke-direct {p0}, Landroidx/camera/video/Quality;-><init>()V

    return-void
.end method

.method static containsQuality(Landroidx/camera/video/Quality;)Z
    .locals 1

    sget-object v0, Landroidx/camera/video/Quality;->QUALITIES:Ljava/util/Set;

    .line 103
    invoke-interface {v0, p0}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result p0

    return p0
.end method

.method public static getSortedQualities()Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Landroidx/camera/video/Quality;",
            ">;"
        }
    .end annotation

    .line 114
    new-instance v0, Ljava/util/ArrayList;

    sget-object v1, Landroidx/camera/video/Quality;->QUALITIES_ORDER_BY_SIZE:Ljava/util/List;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    return-object v0
.end method
